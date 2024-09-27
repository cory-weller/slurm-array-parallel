#!/usr/bin/env bash
#SBATCH --mem 20G
#SBATCH --time 2:59:00
#SBATCH --partition quick,norm
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 4
#SBATCH --gres lscratch:20


# Get job-specific parameters
# SLURM_ARRAY_TASK_ID is automatically assigned to environment when --array is used.
# For example, --array=1-8 will spawn 1 jobs, with SLURM_ARRAY_TASK_ID being 1 through 8.

# If SLURM_NTASKS is undefined, default to first agument.
if [[ -z ${SLURM_ARRAY_TASK_ID} ]]; then
    N=${1}
else
    N=${SLURM_ARRAY_TASK_ID}
fi

echo "Job array N is ${N}"

# In this example, parameters.txt has our job-specific variables
PARAMFILE='parameters.txt'

# Parse job-specific variables by extract the Nth line and splitting the text
sampleID=$(sed -n ${N}p ${PARAMFILE} | awk '{print $1}' )
batch=$(sed -n ${N}p ${PARAMFILE} | awk '{print $2}' )
datatype=$(sed -n ${N}p ${PARAMFILE} | awk '{print $3}' )


# Run myscript.sh with the job-specific arguments
echo "Running command:"
echo bash myscript.sh $sampleID $batch $datatype