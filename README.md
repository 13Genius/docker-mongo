docker-mongodb
====================

Base docker image to run a MongoDB database server


Usage
-----

To create the image `13genius/mongodb`, execute the following command on the 13genius-mongodb folder:

        docker build -t 13genius/mongodb .


Running the MongoDB server
--------------------------

Run the following command to start MongoDB:

        docker run -d -p 27017:27017 -p 28017:28017 13genius/mongodb

The first time that you run your container, a new random password will be set.
To get the password, check the logs of the container by running:

        docker logs <CONTAINER_ID>

You will see an output like the following:

        ========================================================================
        You can now connect to this MongoDB server using:

            mongo admin -u admin -p 5elsT6KtjrqV --host <host> --port <port>

        Please remember to change the above password as soon as possible!
        ========================================================================

In this case, `5elsT6KtjrqV` is the password set.
You can then connect to MongoDB:

         mongo admin -u admin -p 5elsT6KtjrqV

Done!


Setting a specific password for the admin account
-------------------------------------------------

If you want to use a preset password instead of a randomly generated one, you can
set the environment variable `MONGODB_PASS` to your specific password when running the container:

        docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_PASS="mypass" 13genius/mongodb

You can now test your new admin password:

        mongo admin -u admin -p mypass
        curl --user admin:mypass --digest http://localhost:28017/


Setting a specific user:database
--------------------------------

If you want to use another database with another user

    docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_USER="user" -e MONGODB_DATABASE="mydatabase" -e MONGODB_PASS="mypass" 13genius/mongodb

You can now test your new credentials:

    mongo mydatabase -u user -p mypass

Note: with mongo 3.x an admin user is also created with the same credentials

    mongo admin -u user -p mypass

Run MongoDB without password
----------------------------

If you want to run MongoDB without password you can set the environment variable `AUTH` to specific if you want password or not when running the container:

        docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no 13genius/mongodb

By default is "yes".


Run MongoDB with a specific storage engine
------------------------------------------

In MongoDB 3.0 there is a new environment variable `STORAGE_ENGINE` to specific the mongod storage driver:

        docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no -e STORAGE_ENGINE=mmapv1 13genius/mongodb:3.0

By default is "wiredTiger".


Change the default oplog size
-----------------------------

In MongoDB 3.0 the variable `OPLOG_SIZE` can be used to specify the mongod oplog size in megabytes:

        docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no -e OPLOG_SIZE=50 13genius/mongodb:3.0

By default MongoDB allocates 5% of the available free disk space, but will always allocate at least 1 gigabyte and never more than 50 gigabytes.