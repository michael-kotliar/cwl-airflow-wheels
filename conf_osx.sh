#!/usr/bin/env bash

brew install pyenv
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
exec "$SHELL"

for P_VERSION in ${PYTHON_VERSIONS//:/ }; do
    pyenv install "$P_VERSION"
    pyenv rehash
    pyenv local "$P_VERSION"
    pip install --upgrade pip
    pip install wheel --no-cache-dir
    pip install delocate --no-cache-dir
done
