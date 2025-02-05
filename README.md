# BabiBN/subversion-edge

This is a docker image of the Collabnet Subversion Edge Server

## Build

    git clone https://github.com/mamohr/docker-subversion-edge.git
    cd docker-subversion-edge

Then 

    docker build -t edgesvn .
OR

    docker build --pull --rm -f "Dockerfile" -t dockersubversionedge:latest "."

## Usage

The image is exposing the data dir of csvn as a volume under `/opt/csvn/data`.
If you provide an empty host folder as volume the init scripts will take care of copying a basic configuration to the volume.
The container exposes the following ports:

 * 3343 - HTTP CSVN Admin Sites
 * 4434 - HTTPS CSVN Admin Sites (If SSL is enabled)
 * 18080 - Apache Http SVN

The simplest way to start a subversion edge server is

    docker run -d dockersubversionedge

This will run the server. It will only be reachable from the docker host by using the container ip address

Exposing the ports from the host:
    
    docker run -d -p 3343:3343 -p 4434:4434 -p 18080:18080 \
        --name svn-server dockersubversionedge

This will make the admin interface reachable under [http://docker-host:3343/csvn](http://docker-host:3343/csvn).

If you want to provide a host path for the data use command like this:

    docker run -d -p 3343:3343 -p 4434:4434 -p 18080:18080 \
        -v /srv/svn-data:/opt/csvn/data --name svn-server dockersubversionedge
    

For information to further configuration please consult the documentation at [CollabNet](http://collab.net/products/subversion).
