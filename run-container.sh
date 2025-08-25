#!/usr/bin/env bash
# Adapted from
# https://github.com/davetang/learning_docker/blob/main/rstudio/run_docker.sh
# Optimized and unified for Unix/macOS and Git Bash (Windows) by GPT5

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

echo "Operating system: $(uname -s)"

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

# Ensure required options provided
if [[ -z "${ver:-}" || -z "${port:-}" ]]; then
  >&2 echo "Error: Missing required options."
  usage
fi

# Exactly one positional argument (the directory to mount)
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

# Resolve absolute path (portable; macOS lacks readlink -f)
abspath() {
  case "$OS" in
    gitbash)
      # Git Bash: convert to Windows path
      (cd "$1" && pwd -W)
      ;;
    *)
      # Linux/macOS: use realpath if available
      if command -v realpath >/dev/null 2>&1; then
        realpath "$1"
      else
        echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
      fi
      ;;
  esac
}

# Convert a host path to a Docker-friendly path (Git Bash needs Windows-style)
docker_path() {
  local p="$1"
  case "$OS" in
    gitbash)
      # pwd -W returns Windows path for CWD; cd into target first
      ( cd "$p" && pwd -W )
      ;;
    *)
      echo "$p"
      ;;
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
if [[ ! -d "$r_package_dir" ]]; then
  echo "Creating ${r_package_dir}"
  mkdir -p "$r_package_dir"
fi

rstudio_image="agroimpacts/geospaar:${ver}"
prefs="rstudio-prefs.json"

# Pull image if not present
if ! docker image inspect "$rstudio_image" >/dev/null 2>&1; then
  echo "Pulling ${rstudio_image}..."
  docker pull "$rstudio_image"
fi

# Stop and remove any existing container with the same name
if docker ps -a --format '{{.Names}}' | grep -q '^geospaar_rstudio$'; then
  echo "Removing existing container 'geospaar_rstudio'..."
  docker rm -f geospaar_rstudio >/dev/null 2>&1 || true
fi

# --- Run ---

# Map host:${port} -> container:8787
echo "Launching from platform: ${OS}"
docker run --rm -d -p "${port}:8787" -e PASSWORD=password \
  --name geospaar_rstudio \
  -v "$(docker_path "${full_d}")":/home/rstudio \
  -v "$(docker_path "${r_package_dir}")":/packages \
  -v "$(docker_path "${full_d}/geospaar")/${prefs}":/home/rstudio/.config/rstudio/${prefs} \
  -v "$(docker_path "${full_d}/geospaar")/.Rprofile":/home/rstudio/.Rprofile:rw \
  "${rstudio_image}"

echo "geospaar_rstudio listening on port ${port}"
echo "Open:  http://localhost:${port}"
echo "Username: rstudio"
echo "Password: password"
echo "To stop: docker stop geospaar_rstudio"


