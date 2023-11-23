# NextCloud Docker Compose
A docker compose file slightly modified from the official documentation to help bring up NextCloud with a MariaDB backend.

## Highlights:
Some changes vs the NextCloud Docker Compose are:
 - Adds a name to each container for easier management (this can be changed based on user preference
 - Instead of restart: always, using restart: unless-stopped in case some maintenance ever needs to be done.
 - Force Maria DB version 10.5 because some of the newer versions (10.6) have certain incompatibilities
   References: https://github.com/nextcloud/docker/issues/1492 , https://help.nextcloud.com/t/mariadb-upgrade-from-10-5-11-to-10-6-causes-internal-server-error/120585

## NEW Options - 11/23
I created a few new options for the Docker Compose files - one with Redis which helps improve performance, and another file which will create and apply a self-signed SSL certificate for the Nextcloud container. The docker-compose-ssl.yml file requires that the additional Dockerfile be present in the same directory of the docker-compose-ssl.yml file on start up. The other 2 docker-compose files do NOT require the Dockerfile. 

One note is to be careful with the port numbers used in the configs. These can be mapped as preferred. 

## Getting started:
This file should be first modified with the desired local folder/directory under the volumes sections. The database password can also be modified to the desired password.

Once the docker-compose.yml file is configured as desired a simple 'docker-compose up -d' should start the 2 containers, including downloading the images and other necessary files. 

Once both containers are active you should be able to navigate to the server IP port 8080/8443 (or whatever port that was given) and complete setup. 

## Troubleshooting:
With Maria DB a potential issue can be the default compression setting causeing an error with NextCloud. Should this occur there is a fairly simple work around that can be performed by logging into the MariaDB container and adjusting. 

Steps:

&ensp;&ensp;sudo docker exec -it nxtclouddb bash

Then enter the MySQL instance (MariaDB still uses MySQL commands)

&ensp;&ensp;mysql -u root -p

Enter the MySQL root password set in the docker-compose file.

Then run this in the MariaDB server:

&ensp;&ensp;SET GLOBAL innodb_read_only_compressed=OFF;
  
I have some more steps in my blog at https://opensourcetechtrn.blogspot.com/2021/07/nextcloud-in-docker.html

#### NOTE: 

I am no longer seeing this issue occur with MariaDB 10.5 and the latest versions of the NextCloud docker instance.
 
## Note for SELinux
On SELinux-enabled systems using the volume mount from the docker-compose.yml file will cuase an error. For SELinux systems a :z flag is needed. Example below:

&ensp;&ensp;volumes:

&ensp;&ensp;&ensp;&ensp;- localdir: /var/lib/mysql:z
  
I hope this can be helpful for anyone looking to get started using NextCloud in Docker / Podman environments. 
