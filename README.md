# docker-4dn-mcoolQC

_The current version of this pipeline pulls the Docker image from a public AWS Elastic Container Registry. If you prefer to pull from Docker Hub (DH), please use the tagged version utilizing DH: `v1_DH`._

This repo contains the source files for a docker image stored in both `4dndcic/4dn-mcoolqc:v1` and AWS `public.ecr.aws/dcic-4dn/4dn-mcoolqc:v1`.

## Table of contents
* [Cloning the repo](#cloning-the-repo)
* [Tool specifications](#tool-specifications)
* [Building docker image](#building-docker-image)
* [Tool wrappers](#tool-wrappers)
  * [run-mcoolQC.sh](#run-mcoolQC.sh)


## Cloning the repo
```
git clone https://github.com/4dn-dcic/docker-4dn-mcoolQC
cd docker-4dn-mcoolQC
```

## Tool specifications
Major software tools used inside the docker container are downloaded by the script `downloads.sh`. This script also creates a symlink to a version-independent folder for each software tool. In order to build an updated docker image with a new version of the tools, ideally only `downloads.sh` should be modified, but not `Dockerfile`, unless the new tool requires a specific APT tool that need to be downloaded.
The `downloads.sh` file also contains comment lines that specifies the name and version of individual software tools.

## Building docker image
You need docker daemon to rebuild the docker image. If you want to push it to a different docker repo, replace `4dndcic/fastqc:v2` with your desired docker repo name. You need permission to push to `4dndcic/4dn-mcoolqc:v1`.
```
docker build -t 4dndcic/4dn-mcoolqc:v1 .
docker push 4dndcic/4dn-mcoolqc:v1
```
You can skip this if you want to use an already built image on docker hub (image name `4dndcic/4dn-mcoolqc:v1`). The command 'docker run' automatically pulls the image from docker hub.

## Tool wrappers

Tool wrappers are under the `scripts` directory and follow naming conventions `run*.sh`. These wrappers are copied to the docker image at built time and may be used as a single step in a workflow.

```
# default
docker run 4dndcic/4dn-mcoolqc:v1

# specific run command
docker run 4dndcic/4dn-mcoolqc:v1 <run_script> <arg1> <arg2> ...

# may need -v option to mount data file/folder if they are used as arguments.
docker run -v /data1/:/d1/:rw -v /data2/:/d2/:rw 4dndcic/4dn-mcoolqc:v1 <run_script> /d1/file1 /d2/file2 ...
```

### run-mcoolQC.sh
Runs mcoolqc on a given mcool file and produces an mcoolqc report.
* Input: an mcool file
* Output: an mcoolqc report

#### Usage
Run the following in the container
```
run-mcoolQC.sh <input_mcool> <outdir>
# input_mcool : an input mcool file
# outdir : output directory (This should be a mounted host directory, so that the output files are visible from the host and to avoid any bus error)
```
