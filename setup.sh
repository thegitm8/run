#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #

cd
git clone git@github.com:thegitm8/run.git .run
echo "export PATH=$HOME/.run/bin:\$PATH" >> ~/.bashrc


} # this ensures the entire script is downloaded #
