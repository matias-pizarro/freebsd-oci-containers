#!/bin/sh

_GREEN=$(tput setaf 2)
_BLUE=$(tput setaf 4)
_RED=$(tput setaf 1)
_RESET=$(tput sgr0)
_BOLD=$(tput bold)

say_error() {
    echo "${_RED}Error: ${1}${_RESET}"
}

say_critical_error() {
    say_error "${1}"
    exit 1
}

first_char() {
    echo $(printf %.1s ${1})
}

usage() {
    cat << 'EOF'
bump.sh
=======

bumps the specified term of the semver string found in <directory>/version

Usage: bump.sh [-M|m|p] [-nh] <directory>

Options:
    -M   bump major version
    -m   bump minor version
    -p   bump patch version [default]
    -n   return the next version but do not update the version file
    -h   Show this help message and exit

EOF
    exit 1
}

IDX=3
while getopts "Mmph" FLAG; do
    case "${FLAG}" in
    M)
        IDX=1
        ;;
    m)
        IDX=2
        ;;
    p)
        IDX=3
        ;;
    n)
        DRY_RUN=true
        ;;
    h)
        usage
        ;;
    *)
        usage
        ;;
    esac
done

shift $((OPTIND-1))

VERSION_PATH="${1}"

if [ -z "${VERSION_PATH}" ]; then
    say_critical_error "please specify a path"
elif [ "${VERSION_PATH}" = '.' ]; then
    VERSION_PATH=$(pwd)
elif [ ! "$(first_char ${VERSION_PATH})" = '/' ]; then
    VERSION_PATH=$(pwd)/${VERSION_PATH}
fi

VERSION_FILE="${VERSION_PATH}/version"
if [ ! -f "${VERSION_FILE}" ]; then
    say_critical_error "${_BOLD}${VERSION_FILE}${_RESET}${_RED} not found"
fi

CMD='/[0-9]+\./{$'${IDX}'++;print}'
RAW_VERSION="$(cat ${VERSION_FILE} | awk -F. ${CMD} OFS=.)"

MAJOR="$(echo ${RAW_VERSION} | awk -F. '{print $1}')"
MINOR="$(echo ${RAW_VERSION} | awk -F. '{print $2}')"

case "${IDX}" in
1)
    NEW_VERSION="${MAJOR}.0.0"
    ;;
2)
    NEW_VERSION="${MAJOR}.${MINOR}.0"
    ;;
3)
    NEW_VERSION="${RAW_VERSION}"
    ;;
esac

if [ "${DRY_RUN}" = "false" ]; then
    echo ${NEW_VERSION} > "${VERSION_FILE}"
fi

echo ${_GREEN}${NEW_VERSION}${_RESET}${_RESET}
