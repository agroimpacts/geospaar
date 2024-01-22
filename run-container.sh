#!/bin/bash
# Adapted from
# https://github.com/davetang/learning_docker/blob/main/rstudio/run_docker.sh
# Optimized with input from chatGPT 3.5

set -euo pipefail

if ! command -v docker &>/dev/null; then
   >&2 echo "Error: Could not find docker."
   exit 1
fi

usage() {
   echo "Usage: $0 [ -v rstudio_airg version ] [ -p port ] <dirs_to_mount>"
   exit 1
}

# Check the operating system
case "$(uname -s)" in
    Darwin*)    # macOS
        READLINK="greadlink"  # On macOS, use 'greadlink' from coreutils package
        LAUNCHER="nix"
        ;;
    Linux*)     # Linux
        READLINK="readlink"
        LAUNCHER="nix"
        ;;
    CYGWIN*|MINGW32*|MSYS*|MINGW*) # Windows
        READLINK="readlink"
        LAUNCHER="gitbash"
        ;;
    *)
        >&2 echo "Error: Unsupported operating system."
        exit 1
        ;;
esac

echo "Operating system: $(uname -s)"

while getopts ":v:p:" options; do
   case "${options}" in
      v)
         ver=${OPTARG}
         ;;
      p)
         port=${OPTARG}
         ;;
      :)
         echo "Error: -${OPTARG} requires an argument."
         exit 1
         ;;
      *)
      usage ;;
   esac
done

# Check if required arguments are set
if [[ -z "$ver" || -z "$port" ]]; then
    >&2 echo "Error: Not all required commands are entered."
    usage
fi

if [[ $# -ne $((OPTIND)) ]]; then
    >&2 echo "Error: Invalid number of arguments. \
    Please provide exactly $((OPTIND)) arguments."
    exit 1
fi


# Mount main project directory
d=${@:$OPTIND:1}
full_d=$($READLINK -f "${d}")
if [[ ! -d "${full_d}" ]]; then
  >&2 echo "Error: Directory ${full_d} does not exist."
  exit 1
fi

bname=$(basename ${full_d})
if [[ "${bname}" == "geospaar"  ]]; then
  >&2 echo "The mount directory cannot include geospaar, it should be"
  >&2 echo "geospaar's parent directory"
  exit 1
fi

# Make package directory
r_package_dir=${full_d}/r_${ver}_packages
if [[ ! -d ${r_package_dir} ]]; then
   echo "Creating ${r_package_dir}"
   mkdir -p "${r_package_dir}"
fi

rstudio_image=agroimpacts/geospaar:${ver}
check_image=$(docker image inspect ${rstudio_image})
prefs=rstudio-prefs.json

# # Running rstudio on localhost:8787
cd ${full_d}
if [[ "${LAUNCHER}" == "nix"  ]]; then
  echo Launching from a $LAUNCHER platform
  docker run --rm -d -p 8787:${port} -e PASSWORD=password \
    --name geospaar_rstudio \
    -v "${full_d}":/home/rstudio/ \
    -v "${r_package_dir}":/packages \
    -v "${full_d}"/geospaar/"${prefs}":/home/rstudio/.config/rstudio/"${prefs}" \
    -v "${full_d}"/geospaar/.Rprofile:/home/rstudio/.Rprofile:rw \
    "${rstudio_image}"
fi

if [[ "${LAUNCHER}" == "gitbash"  ]]; then
  echo Launching from a $LAUNCHER platform
  winpty docker run --rm -d -p 8787:8787 -e PASSWORD=password \
    --name geospaar_rstudio \
    -v /$PWD:/home/rstudio/ \
    -v /$PWD/r_$VER_packages:/packages \
    -v /$PWD/geospaar/$prefs:/home/rstudio/.config/rstudio/$prefs \
    -v /$PWD/geospaar/.Rprofile:/home/rstudio/.Rprofile:rw \
    $rstudio_image
fi

echo "geospaar_rstudio listening on port ${port}"
echo "Copy and paste http://localhost:${port} into your browser"
echo "Username is rstudio and password is password"
echo "To stop container run: docker stop geospaar_rstudio"
# open http://localhost:${port}



