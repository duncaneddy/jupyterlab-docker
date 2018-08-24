# jupyterlab-docker

A simple docker container to create a jupyterlab instance for development with the Python 2, Python 3, and Julia Kernels installed by default.

## Requirements

- Docker >= 18.04 (Though older versions will likely work)
- Docker-Compose >= 3.6

## Setup

First clone or download the repository to the location of your choice. You can
build the docker image from this directory using the command:

```
docker-compose build
```

## Usage

After having built the image, simply start the jupyterlab server using:

```
docker-compose up
```

Now you can point your browser of choice to `localhost:9001` to view the
notebook.

## Known Issues

The IJulia kernel is not installed by default, though Julia 1.0 is. The IJulia
kernel can be installed using the following steps:

1. Start the jupyterlab server
2. Open a terminal session in jupyter lab and type: `julia`
3. Enter the juila package environment by typing: `]`
4. Install the IJulia kernel with: `add IJulia`
5. Exit the Julia package manager by hitting `backspace`
6. Exit the Julia REPL by entering `exit()`
7. Refersh the webpage and Julia will now be a notebook option.