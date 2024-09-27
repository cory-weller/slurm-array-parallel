#!/usr/bin/env bash
#SBATCH --ntasks 4
#SBATCH --cpus-per-tak 1
#SBATCH --mem-per-cpu 6G
#SBATCH --time 2:59:00
#SBATCH --partition quick,norm


# This script will execute all of the tasks in parallel, but on a single requested
# HPC node. This is good when you have many things that run quickly,
# because it avoids jobs waiting in queue. You get one big node and run things on it

PARAMFILE=parameters.txt

myfunction() {
    local sampleID=${1}
    local batch=${2}
    local datatype=${3}
    # I put `echo` here just so it will print out the command to see what it does.
    echo "Running command:"
    echo bash myscript.sh $sampleID $batch $datatype
}

# Export the function 
# Without this, the function is not visible to parallel's child processes
export -f myfunction

# If SLURM_NTASKS is undefined, default to one task at a time.
if [[ -z ${SLURM_NTASKS} ]]; then
    SLURM_NTASKS=1
fi

# Run `myfunction` using the file `parameters.txt` line by line
# with all three arguments, in order
parallel -j ${SLURM_NTASKS} -a ${PARAMFILE} myfunction {}

# Note that {} defaults to all arguments in the file, in order.
# You can also use a subset of arguments by specifying their index
# e.g.
# parallel -j ${SLURM_NTASKS} -a ${PARAMFILE} myfunction {1} {2}
