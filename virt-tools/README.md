# Virtualization-PT supporting tools container (WIP)

**This container contains all tools needed for the course "VIRT-PT/MCCE/UAS-Burgenland"**

Current Contents:
* Terraform CLI
* Google Cloud SDK
* AWS-CLI (to be included)

Prerequisites:
* Docker installed on your machine 

Usage:
* For persistence, create a home-directory on your machine:
```shell
mkdir ${HOME}/mcce-workspace
```
* Run the Container 
```shell
docker run -it -v ${HOME}/mcce-workspace:/home/labuser ghcr.io/thschue/uas-virt-tools:latest (will be changed soon)
```

* Now you get a shell and can use above tools

## Q/A
Q: I want to check the authenticity of this container

A: Install cosign (https://github.com/sigstore/cosign), Fetch the public key of the images (https://github.com/thschue/uas-containers/blob/main/.github/workflows/cosign.pub) and run `cosign verify -key ./cosign.pub ghcr.io/thschue/uas-virt-tools:<TAG>`