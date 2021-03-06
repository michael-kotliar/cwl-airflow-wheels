#!/usr/bin/env bash

for PYBIN in /opt/python/*/bin; do
  mkdir packages
  cd packages
  "${PYBIN}/pip" download --no-cache-dir -r ../requirements.txt
  cd ..
  for PACKAGE in packages/*; do
    "${PYBIN}/pip" wheel "./${PACKAGE}/" -w tmp
  done
  rm -rf packages
done

# Bundle external shared libraries into the wheels
for whl in tmp/*.whl; do
    auditwheel repair "$whl" -w wheelhouse
done

rm -rf tmp