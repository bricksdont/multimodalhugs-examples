# O'Brien et al. 2026: Comparing Pose Estimators for Sign Language Translation

This experiment trains one model per pose estimator on the Phoenix dataset and compares their BLEU scores, following the setup of O'Brien et al. (2026).

## Pose types

Eight pose estimators are evaluated:

| Pose type | Keypoints             | Format   | Expected feat_dim |
|---|-----------------------|----------|---|
| `alphapose_136` | 136                   | XY (2D)  | 272 |
| `mediapipe` | 178 (after reduction) | XYZ (3D) | 534 |
| `mmposewholebody` | 133                   | XY       | 266 |
| `openpifpaf` | 133                   | XY       | 266 |
| `openpose` | 137                   | XY       | 274 |
| `sapiens` | 310                   | XY       | 620 |
| `sdpose` | 133                   | XY       | 266 |
| `smplest_x` | 139                   | XY       | 278 |

Pre-estimated poses are downloaded automatically from a Cloudflare R2 bucket during preprocessing — this code does **not** run pose estimation itself.
See [`POSE_DOWNLOAD_URLS`](../../scripts/preprocessing/preprocess.py) for the exact URLs.

To repeat the pose estimation step, or to apply a different dataset, see the companion repository: [ZurichNLP/video-to-pose](https://github.com/ZurichNLP/video-to-pose).

## How to run

For maximum reproducibility, check out the tagged version of this codebase before running:

```bash
git checkout o_brien_et_al_2026
```

First create and populate the experiment venv (only needed once):

```bash
bash experiments/o_brien_et_al_2026/install.sh
```

Then submit the SLURM jobs:

```bash
bash scripts/running/run_o_brien_et_al_2026.sh
```

This submits 8 × 3 × 4 SLURM jobs (preprocess → train → translate → evaluate) with model names of the form `o_brien_et_al_2026+pose_type.<pose_type>+seed.<seed>`.

## Hyperparameters

Best hyperparameters from the hyperparameter search experiment are used:

- `learning_rate`: 1e-5
- `warmup_steps`: 500
- `label_smoothing_factor`: 0.1
- `gradient_accumulation_steps`: 3

## Results

These scores are a reproduction run by the original authors and may differ slightly from the numbers reported in the paper due to software and environment differences.

| Pose type | Seed | BLEU | BLEURT |
|---|---|---|---|
| `alphapose_136` | 375678 | 11.275 | 0.364 |
| `alphapose_136` | 534 | 11.493 | 0.368 |
| `alphapose_136` | 42 | 10.725 | 0.344 |
| `mediapipe` | 375678 | 10.337 | 0.344 |
| `mediapipe` | 534 | 10.083 | 0.342 |
| `mediapipe` | 42 | 9.765 | 0.347 |
| `mmposewholebody` | 375678 | 10.184 | 0.346 |
| `mmposewholebody` | 534 | 10.510 | 0.356 |
| `mmposewholebody` | 42 | 10.881 | 0.358 |
| `openpifpaf` | 375678 | 9.598 | 0.330 |
| `openpifpaf` | 534 | 9.611 | 0.339 |
| `openpifpaf` | 42 | 9.711 | 0.339 |
| `openpose` | 375678 | 10.915 | 0.351 |
| `openpose` | 534 | 10.301 | 0.354 |
| `openpose` | 42 | 10.601 | 0.356 |
| `sapiens` | 375678 | 11.799 | 0.381 |
| `sapiens` | 534 | 11.440 | 0.369 |
| `sapiens` | 42 | 11.124 | 0.371 |
| `sdpose` | 375678 | 11.949 | 0.371 |
| `sdpose` | 534 | 11.095 | 0.357 |
| `sdpose` | 42 | 12.000 | 0.373 |
| `smplest_x` | 375678 | 9.763 | 0.339 |
| `smplest_x` | 534 | 9.894 | 0.333 |
| `smplest_x` | 42 | 10.058 | 0.335 |

## Analysis

The [`analysis/`](analysis/) directory contains the scripts used to produce the analysis tables and figures in the paper:

- [`missing_hand_analysis.py`](analysis/missing_hand_analysis.py) — sweeps missing-hand percentage across pose estimators at varying confidence and missing-ratio thresholds.
- [`motion_jitter_analysis.py`](analysis/motion_jitter_analysis.py) — computes motion energy and jitter (acceleration, jerk) per sequence and plots their distributions across estimators.

## Citation

```bibtex
@misc{obrien2026comparing,
  title        = {Comparing Pose Estimators for Sign Language Translation},
  author       = {O'Brien, Catherine and Sant, Gerard and M\"{u}ller, Mathias and Ebling, Sarah},
  year         = {2026},
  eprint       = {2604.24609},
  archivePrefix= {arXiv},
  primaryClass = {cs.CL},
  url          = {https://arxiv.org/abs/2604.24609},
}
```
