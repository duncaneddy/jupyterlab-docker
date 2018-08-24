# Use Ubuntu 18.04 as base image
FROM ubuntu:bionic

# Install OS packages 
RUN apt update
RUN apt upgrade -y
RUN apt install -y wget less curl gcc vim emacs
RUN apt install -y python-dev python-pip python3-dev python3-pip

# Install and configure Jupyterlab and Python 2/3 kernels
RUN mkdir -p /opt/jupyterlab/
RUN pip3 install jupyterlab jupyter ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab
RUN pip install ipykernel
RUN pip3 install ipykernel
RUN python3 -m ipykernel install
RUN python2 -m ipykernel install

# Install Julia
WORKDIR /julia
RUN wget "https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.0-linux-x86_64.tar.gz"
RUN tar -zxvf julia-1.0.0-linux-x86_64.tar.gz
RUN rm julia-1.0.0-linux-x86_64.tar.gz
WORKDIR /usr/local/bin
RUN ln -s /julia/julia-1.0.0/bin/julia julia 

# Install IJulia Kernel
# RUN julia -i; echo "]" ; echo "add IJulia"; echo "\b"; echo "exit()"

# Set blank password on notebook. Comment out this to remove
RUN echo "c.NotebookApp.token = u''" >> ~/.jupyter/jupyter_notebook_config.py

# Set working directory
WORKDIR /opt/jupyterlab

############################
# Install Default Packages #
############################

# Put commands here to insall certain packages as part of the image build

# Example default package installation
# RUN pip3 install numpy scipy matplotlib

##########################
# Launch Notebook Server #
##########################

# Expose lab server port and run
EXPOSE 9001
CMD jupyter lab --ip=* --port=9001 --no-browser --notebook-dir=/opt/jupyterlab/ --allow-root --NotebookApp.token=