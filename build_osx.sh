#!/usr/bin/env bash

for P_VERSION in ${PYTHON_VERSIONS//:/ }; do
  pyenv local "$P_VERSION"
  mkdir packages
  cd packages
  pip download --no-cache-dir -r ../requirements.txt
  cd ..
  for PACKAGE in packages/*; do
    pip wheel "./${PACKAGE}/" -w tmp
  done

  delocate-wheel tmp/*.whl
  delocate-addplat -k --rm-orig -x 10_9 -x 10_10 tmp/*.whl
  mv tmp/*.whl wheelhouse
  rm -rf tmp packages
done



