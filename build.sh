#!/usr/bin/env bash

for image in controller sensor valve; do
  (
    cd ${image}
    docker build . -t swe-${image}
  )
done
