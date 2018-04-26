#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for i in $DIR/slave_build/*.sh; do
  bash "$i" -H
done
