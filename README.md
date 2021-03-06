# Hack Oregon Emergency Response PostGIS Docker Image

This is source code for docker image available [here](https://hub.docker.com/r/brianhgrant/ho-emergency_db/) and can be used to build the docker container for the PostGIS database used by the Hack Oregon 2017 Emergency Response team.

## To Build

Fork and clone repo locally

Due to file size the sql dumpfile will need to be downloaded  [here](https://drive.google.com/file/d/0B7k-dMOX1R5WOWpTZDdhMFBMUW8/view?usp=sharing).  

Save the file to the root directory of this repo and rename with a .sql extension:  

    ./fire_db_2010.sql

Use secrets-template file to create a secrets file:

    # rename the template file
    $ mv ./bin/secrets-template.sh ./bin/secrets.sh
    # edit the file to enter your db username and password
    $ vi ./bin/secrets.sh

    #! /bin/bash
    # Setup Project Specfics - Secrets
    # Do not upload to github.  Make sure secrets.sh is in .gitignore
    # These will need to match your database settings in django or other app.
    export DB_USER=<YOUR_USER_NAME>
    export DB_USER_PASS=<YOUR_DB_PASSWORD>

Next just build docker image:  

    $ docker build -t ho_emergency_db .

Image will be built locally and able to be used in project
