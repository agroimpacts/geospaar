#!/usr/bin/env bash
# Adapted from
# https://github.com/davetang/learning_docker/blob/main/rstudio/run_docker.sh
# Heavily optimized and rewritten for Unix/macOS and Git Bash (Windows) by GPT-5

set -euo pipefail

if ! command -v docker &>/dev/null; then
   >&2 echo "Error: Could not find docker."
   exit 1
fi

usage() {
   echo "Usage: $0 -v <rstudio_airg version> -p <host_port> <dir_to_mount>"
   echo "Example: $0 -v 4.3.2 -p 8787 /path/to/projects"
   exit 1
}

# Detect platform
case "$(uname -s)" in
  Darwin*)    OS="mac" ;;
  Linux*)     OS="linux" ;;
  CYGWIN*|MINGW32*|MSYS*|MINGW*) OS="gitbash" ;;
  *)          >&2 echo "Error: Unsupported operating system ($(uname -s))."; exit 1 ;;
esac

# Parse options
ver=""
port=""
while getopts ":v:p:" options; do
  case "${options}" in
    v) ver=${OPTARG} ;;
    p) port=${OPTARG} ;;
    :) echo "Error: -${OPTARG} requires an argument." ; exit 1 ;;
    *) usage ;;
  esac
done

if [[ -z "${ver:-}" || -z "${port:-}" ]]; then
  >&2 echo "Error: Missing required options."
  usage
fi

if (( $# < OPTIND )); then
  >&2 echo "Error: Missing <dir_to_mount>."
  usage
fi
if (( $# > OPTIND )); then
  >&2 echo "Error: Too many positional arguments."
  usage
fi

d="${!OPTIND}"

# --- Helpers ---

abspath() {
  case "$OS" in
    gitbash) (cd "$1" && pwd -W) ;;   # Git Bash: Windows path
    *)
      if command -v realpath >/dev/null 2>&1; then
        realpath "$1"
      else
        echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
      fi
      ;;
  esac
}

docker_path() {
  local p="$1"
  case "$OS" in
    gitbash) ( cd "$p" && pwd -W ) ;;
    *) echo "$p" ;;
  esac
}

# --- Main prep ---

full_d="$(abspath "$d")"
if [[ ! -d "$full_d" ]]; then
  >&2 echo "Error: Directory ${full_d} does not exist."
  exit 1
fi

bname="$(basename "$full_d")"
if [[ "$bname" == "geospaar" ]]; then
  >&2 echo "The mount directory cannot be 'geospaar'; use geospaar's parent directory."
  exit 1
fi

r_package_dir="${full_d}/r_${ver}_packages"
mkdir -p "$r_package_dir"

# --- RStudio config + prefs setup ---
config_dir="${full_d}/geospaar/.config/rstudio"
mkdir -p "$config_dir"

prefs="${config_dir}/rstudio-prefs.json"
if [[ ! -f "$prefs" ]]; then
  echo "Creating empty prefs file at ${prefs}"
  echo '{}' > "$prefs"
fi

# Optionally ensure .Rprofile exists
rprofile="${full_d}/geospaar/.Rprofile"
if [[ ! -f "$rprofile" ]]; then
  echo "Creating empty .Rprofile at ${rprofile}"
  touch "$rprofile"
fi

rstudio_image="agroimpacts/geospaar:${ver}"

# Pull image if not present
if ! docker image inspect "$rstudio_image" >/dev/null 2>&1; then
  echo "Pulling ${rstudio_image}..."
  docker pull "$rstudio_image"
fi

# Stop and remove any existing container
if docker ps -a --format '{{.Names}}' | grep -q '^geospaar_rstudio$'; then
  echo "Removing existing container 'geospaar_rstudio'..."
  docker rm -f geospaar_rstudio >/dev/null 2>&1 || true
fi

# --- Run ---
echo "Launching from platform: ${OS}"
docker run --rm -d -p "${port}:8787" -e PASSWORD=password \
  -e USERID="$(id -u)" -e GROUPID="$(id -g)" \
  --name geospaar_rstudio \
  -v "$(docker_path "${full_d}")":/home/rstudio \
  -v "$(docker_path "${r_package_dir}")":/packages \
  -v "$(docker_path "${config_dir}")":/home/rstudio/.config/rstudio \
  -v "$(docker_path "${rprofile}")":/home/rstudio/.Rprofile:rw \
  "${rstudio_image}"

echo "geospaar_rstudio listening on port ${port}"
echo "Open:  http://localhost:${port}"
echo "Username: rstudio"
echo "Password: password"
echo "To stop: docker stop geospaar_rstudio"
