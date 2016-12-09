#!/bin/bash

for file in dot.*; do
  rm -rf ~/.`echo ${file/dot/} | cut -d "." -f 2`
done
