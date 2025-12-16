#! /bin/bash

module load gpu cuda/12.6.2 cudnn/9.5.1.17-12 miniforge3

environment_scripts=$(dirname "$0")
scripts=$environment_scripts/..
base=$scripts/..

venvs=$base/venvs
tools=$base/tools

mkdir -p $tools

source activate $venvs/huggingface

# install multimodalhugs

git clone https://github.com/GerrySant/multimodalhugs.git $tools/multimodalhugs

# pin commit  https://github.com/GerrySant/multimodalhugs/commit/8e689e30afd1eee8712cc80070daafe17946d133
# to avoid unintentionally breaking the code

(cd $tools/multimodalhugs && git checkout "8e689e30afd1eee8712cc80070daafe17946d133")

(cd $tools/multimodalhugs && pip install .)

# install SL datasets

pip install git+https://github.com/sign-language-processing/datasets.git

# TF keras, because keras 3 is not supported in Transformers

pip install tf-keras

# bleurt not supported out of the box with evaluate

pip install git+https://github.com/google-research/bleurt.git
