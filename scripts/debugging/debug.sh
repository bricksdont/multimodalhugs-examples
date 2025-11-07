#! /bin/bash

# (srun --pty -n 1 -c 2 --time=01:00:00 --mem=16G bash)

module load anaconda3

source activate /shares/sigma.ebling.cl.uzh/mathmu/multimodalhugs-examples/venvs/huggingface

python /shares/sigma.ebling.cl.uzh/mathmu/multimodalhugs-examples/scripts/debugging/debug_reproducibility.py \
    --checkpoint-1 /shares/sigma.ebling.cl.uzh/mathmu/multimodalhugs-examples/models/phoenix_1/setup/model \
    --checkpoint-2 /shares/sigma.ebling.cl.uzh/mathmu/multimodalhugs-examples/models/phoenix_2/setup/model
