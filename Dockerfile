FROM jupyter/scipy-notebook

USER root

# --------------------
# INSTALL OS PACKAGES
# --------------------

# Update packages
RUN apt-get update -y

# Install Python Setuptools
RUN apt-get install -y python-setuptools
RUN apt-get install -y libxml2-dev libxslt1-dev python-dev libmysqlclient-dev libpq-dev

# needed to install psycopg2 succesfully
RUN apt-get install -y libpq-dev

# ---------------------
# CONFIG DIRS IN OS
# ---------------------
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN chmod -R a+rx /usr/src/app/

## setup pgpass for postgres creds
# ENV PGPASSFILE /usr/src/app/pgpass
# RUN touch /usr/src/app/pgpass
# RUN echo 'server:port:database:username:password' > /usr/src/app/pgpass

## PGPASSLIB need 700 permissions on pgpass
# RUN chmod 700 /usr/src/app/pgpass

# ------------------------
# Install app dependencies
# ------------------------

# private ngv repos
# RUN pip2 install git+https://GITHUB_AUTH_KEY:x-oauth-basic@github.com/REPO_PATH/REPO#egg=my_lib_name
RUN pip2 install -r requirements.txt

# Indicate what port needs to be mapped by the docker daemon
EXPOSE 5000

# ------------------------
# RUN APP
# ------------------------
# Define the command to start the app
CMD /bin/bash -c "source activate python2 && gunicorn --config=gunicorn.py application:application"