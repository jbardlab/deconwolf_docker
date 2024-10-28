# deconwolf_docker
Docker for running deconwolf

Docker container, to run deconwolf: https://github.com/elgw/deconwolf

Container was originally built from the nvidia cuda docker: 12.6.2-cudnn-devel-ubuntu22.04 (12.6.2/ubuntu2204/devel/cudnn/Dockerfile)⁠

# build instructions

Dockerfile is hosted on the Github Container Registry:
To build:

```bash
docker build -t ghcr.io/your_org/deconwolf-docker:v0.4.3 .
```

# Run on TAMU HPRC (Grace)

To run on the TAMU HPRC Grace cluster, you will need to use the Singularity container. The following instructions are based off of: https://hprc.tamu.edu/kb/Software/Singularity/#getting-a-container-image

To pull singularity containers on Grace, you need to open an interactive session

Open a terminal and ssh into grace:
```bash
ssh <username>@grace.hprc.tamu.edu
```

Then open an interactive session from the login node:
```bash
srun --nodes=1 --ntasks-per-node=4 --mem=30G --time=01:00:00 --pty bash -i
```

Once on a compute node:

```bash
cd $SCRATCH
export SINGULARITY_CACHEDIR=$TMPDIR/.singularity
module load WebProxy
singularity pull deconwolf_dockerv0.4.3.sif docker://ghcr.io/jbardlab/deconwolf_docker:v0.4.3 
#(wait for download and convert)
exit
```
