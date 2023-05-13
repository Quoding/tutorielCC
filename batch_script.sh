#!/bin/bash
#SBATCH --account=def-sponsor00
#SBATCH --mem=2G                                        # increase as needed
#SBATCH --mail-type=END,FAIL                            # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=youremail@whatever.com              # Where to send mail
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1                               # Run on a single CPU
#SBATCH --output=logs/slurm-%j.log                      # Output path for logs, %j is the jobid

module load python/3.8
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt

python script.py
