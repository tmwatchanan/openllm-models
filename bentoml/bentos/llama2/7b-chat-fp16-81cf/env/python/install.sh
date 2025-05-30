#!/usr/bin/env bash
set -exuo pipefail

# Parent directory https://stackoverflow.com/a/246128/8643197
BASEDIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )"

if [ -n "${VIRTUAL_ENV:-}" ]; then
    echo "Activating virtualenv at $VIRTUAL_ENV"
    source "$VIRTUAL_ENV/bin/activate"
fi

pip_install() {
    if command -v "uv" > /dev/null 2>&1; then
        uv pip install "$@"
    else
        pip3 install "$@"
    fi
}

PIP_ARGS=()

# BentoML by default generates two requirement files:
#  - ./env/python/requirements.lock.txt: all dependencies locked to its version presented during `build`
#  - ./env/python/requirements.txt: all dependencies as user specified in code or requirements.txt file
REQUIREMENTS_TXT="$BASEDIR/requirements.txt"
REQUIREMENTS_LOCK="$BASEDIR/requirements.lock.txt"
WHEELS_DIR="$BASEDIR/wheels"
BENTOML_VERSION=${BENTOML_VERSION:-1.3.20}
# Install python packages, prefer installing the requirements.lock.txt file if it exist
pushd "$BASEDIR" &>/dev/null
if [ -f "$REQUIREMENTS_LOCK" ]; then
    echo "Installing pip packages from 'requirements.lock.txt'.."
    pip_install "${PIP_ARGS[@]}" -r "$REQUIREMENTS_LOCK"
else
    if [ -f "$REQUIREMENTS_TXT" ]; then
        echo "Installing pip packages from 'requirements.txt'.."
        pip_install "${PIP_ARGS[@]}" -r "$REQUIREMENTS_TXT"
    fi
fi
popd &>/dev/null

# Attempt to expand the glob pattern. The nullglob option ensures that
# the pattern itself is not returned if no files match.
shopt -s nullglob
wheels=($WHEELS_DIR/*.whl)

if [ ${#wheels[@]} -gt 0 ]; then
    echo "Installing wheels packaged in Bento.."
    pip_install "${PIP_ARGS[@]}" "${wheels[@]}"
fi


# Install the BentoML from PyPI if it's not already installed
if python3 -c "import bentoml" &> /dev/null; then
    existing_bentoml_version=$(python3 -c "import bentoml; print(bentoml.__version__)")
    if [ "$existing_bentoml_version" != "$BENTOML_VERSION" ]; then
        echo "WARNING: using BentoML version ${existing_bentoml_version}"
    fi
else
    pip_install bentoml=="$BENTOML_VERSION"
fi