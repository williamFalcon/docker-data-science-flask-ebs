FROM jupyter/scipy-notebook

USER root

# Update packages
RUN apt-get update -y

# Install Python Setuptools
RUN apt-get install -y python-setuptools
RUN apt-get install -y libxml2-dev libxslt1-dev python-dev libmysqlclient-dev

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN chmod -R a+rx /usr/src/app/

# Install app dependencies
RUN pip2 install -r requirements.txt

# Indicate what port needs to be mapped by the docker daemon
EXPOSE 5000

# Define the command to start the app
CMD /bin/bash -c "source activate python2 && python application.py"