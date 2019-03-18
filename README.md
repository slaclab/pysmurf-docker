# Docker image with Rogue for the SMuRF project

## Description

This docker image, named **pysmurf** contains pysmurf and additional tools used by the SMuRF project.

It is based on the **smurf-base** docker image and contains Rogue.

## Source code

Rogue source code is checked out for the SLAC's github repository https://github.com/slaclab/pysmurf.

## How to get the container

To get the docker image, first you will need to install the docker engine in you host OS. Then you can pull a copy by running:

```
docker pull tidair/pysmurf:<TAG>
```

Where **<TAG>** represents the specific tagged version you want to use.

## Building the image

When a tag is pushed to this github repository, a new Docker image is automatically built and push to its [Dockerhub repository](https://hub.docker.com/r/tidair/pysmurf) using travis.

The resulting docker image is tagged with the same git tag string (as returned by `git describe --tags --always`).

## Using the container

The container when started by default starts a ipython3 session and loads the `scrips/pysmurf_startup.py` file.

Pysmurf needs a location to write data. That locations inside the container is `/data/smurf_data`. So, you need to have those directories in the host CPU and mount then inside the container.

On the other hand, pysmurf run in a ipyhton3 session as the **cryo** user. If you want to keep the ipython history you need to mount a local directory as `/home/cryo/` inside the container.

With all that in mind, the command to run the container looks something like this:

```
docker run -ti --rm \
    -v <local_data_dir>:/data \
    -v <local_home_dir>:/home/cryo \
    tidair/pysmurf:<TAG> \
```
Where:
- **<local_data_dir>**: is a local directory in the host CPU which contains the directory `smurf_data` where the data is going to be written to,
- **<local_home_dir>**: is the local directory in the host CPU which will hold the cryo user home directory inside the docker, in order to maintain the ipython history,
- **<TAG>**: is the tagged version of the container your want to run.