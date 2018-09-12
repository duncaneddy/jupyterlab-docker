# jupyterlab-docker

A simple template project for research projects. Contains a docker container 
for hosting a jupyterlab instance for development with the Python 2, Python 3, 
and Julia Kernels installed by default.

Also contains example project structure.

# Requirements

- Docker >= 18.04 (Though older versions will likely work)
- Docker-Compose >= 3.6
- Python 3.6 (or greater)

## Package Installation

To install the python packages and run the code natively, run the following from
the project root:

```
pip3 install -r requirements.txt
```

## Pipenv Installation

It can be easier to use pipenv to install the dependencies in a virual environment.

First install pipenv:

```
pip3 install -U pipenv
```

Then create a virtual envrionment will the required dependencies:

```
pipenv --python 3.6 install -r requirements.txt
```

The virtual environment can then be activated with:

```
pipenv shell
```

Unit tests can then be run with:
```
pytest
```

And finally you can exit the virtual environment with:
```
exit
```

## Jupyterlab Setup

First clone or download the repository to the location of your choice. You can
build the docker image from this directory using the command:

```
docker-compose build
```

## Jupyterlab Usage

After having built the image, simply start the jupyterlab server using:

```
docker-compose up
```

Now you can point your browser of choice to `localhost:9001` to view the
notebook.

## Running Unit Tests

If you write unit tests for your libraries and code (if you do you're a person
of exceeding quality and taste), you can place them all in the `tests` folder
in the project.

To run the tests simply type: 
```
pytest
```

To run the same tests with a test coverage report
```
pytest --cov=lib
```

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