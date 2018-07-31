#!/usr/bin/env bash

brew outdated pyenv || brew upgrade pyenv

for P_VERSION in ${PYTHON_VERSIONS//:/ }; do
    pyenv install "$P_VERSION"
    pyenv rehash
    pyenv local "$P_VERSION"
    pip install --upgrade pip
    pip install wheel --no-cache-dir
    pip install delocate --no-cache-dir
done