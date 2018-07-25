#!/usr/bin/env bash

here=$(dirname $0)

MAPS="virtual"

for map in $MAPS; do
  postmap $here/$map
done
