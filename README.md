# README

This contains examples on running HPC jobs with `SLURM` job management in two ways:
- as a job array, where every job is submitted separately: [`array.sh`](array.sh)
- as a single job, but with parallel execution within the node [`parallel.sh`](parallel.sh)

In both cases, the parameters for individual jobs are defined in [`parameters.txt`](parameters.txt)

The array job would be submitted as `sbatch --array=1-8 array.sh`.  
You can check how the individual jobs in the array would run by executing:
`bash array.sh 1` or `bash array.sh 2` etc.

The parallel job would be submitted as `sbatch parallel.sh`. You can test run it locally `bash parallel.sh`