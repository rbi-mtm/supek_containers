# Containers on Supek

It is [advised](https://wiki.srce.hr/spaces/NR/pages/130023984/Apptainer) to install Python packages on Supek into containers using Apptainer. The documentation of the process is in Croatian and might be annoying to sift through for beginners. This repository simplifies the process.

## Setting Up

Create a directory where you will store your containers:

```bash
mkdir ~/containers
```

and put the ``build_container.sh`` script into ``~/containers``.

Append the following lines to ``~/.bashrc``:

```bash
export PATH="/lustre/home/${USER}/containers:$PATH"
export C="/lustre/home/${USER}/containers"
alias activate='singularity shell'
```

## Building Containers

Write a container [definition file](https://apptainer.org/docs/user/main/definition_files.html) in ``~/containers``. E.g., the following example ``hea.def`` file installs a Python package from a GitHub repository:

```bash
Bootstrap: docker
From: condaforge/miniforge3

%post

  apt update
  apt -y install vim git less

  git clone https://github.com/ovcarj/hea
  cd hea

  conda create -n hea python=3.13
  . /opt/conda/bin/activate
  conda activate hea
  python -m pip install -e .

%environment

  . /opt/conda/bin/activate
  conda activate hea

```

The ``%environment`` section ensures that the Conda environment containing the installed packages is activated whenever the container is activated.

Build the container:

```bash
bash build_container.sh hea.sif hea.def
```

Activate the container:

```bash
activate $C/hea.sif
```
