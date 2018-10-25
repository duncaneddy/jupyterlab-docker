# Use Ubuntu 18.04 as base image
FROM ubuntu:bionic

# Install OS packages 
RUN apt update
RUN apt upgrade -y
RUN apt install -y wget less curl gcc vim emacs

# Install Python 2
RUN apt install -y python-dev python-pip 

# Install Python 3 (Version 3.6 is the default on Ubuntu 18.04)
RUN apt install -y python3-dev python3-pip

# Install Node.js and npm (dependencies for Jupyterlab extensions)
RUN apt install -y nodejs npm

# Install and configure Jupyterlab
RUN mkdir -p /opt/jupyterlab/
RUN pip3 install jupyterlab jupyter ipywidgets
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter nbextension enable --py widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab

# Configure Jupyterlab Kernel for Python 2 & 3
RUN pip install ipykernel
RUN pip3 install ipykernel
RUN python3 -m ipykernel install
RUN python2 -m ipykernel install

# Install Julia
WORKDIR /julia
RUN wget "https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.1-linux-x86_64.tar.gz"
RUN tar -zxvf julia-1.0.1-linux-x86_64.tar.gz
RUN rm julia-1.0.1-linux-x86_64.tar.gz
WORKDIR /usr/local/bin
RUN ln -s /julia/julia-1.0.1/bin/julia julia 

# Install IJulia for Jupyterlab
RUN julia -e 'using Pkg; pkg"add IJulia"'

# Set blank password on notebook. Comment out this to require password on startup
RUN echo "c.NotebookApp.token = u''" >> ~/.jupyter/jupyter_notebook_config.py

# Set working directory
WORKDIR /opt/jupyterlab

############################
# Install Default Packages #
############################

# Put commands here to insall certain packages as part of the image build

# Example default package installation
RUN pip3 install numpy scipy matplotlib

##########################
# Launch Notebook Server #
##########################

# Expose lab server port and run
EXPOSE 9999
CMD jupyter lab --ip=0.0.0.0 --port=9999 --no-browser --notebook-dir=/opt/jupyterlab/ --allow-root --NotebookApp.token=