#!/bin/bash
 
yarn test:ui
test_outcome=$? 
mv ./app /deploy-app

if [[ $test_outcome -ne 0 ]]; then
  exit 1
fi 