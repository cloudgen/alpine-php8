# Alpine nginx 1.23

This nginx 1.23 docker image based on [Alpine](https://hub.docker.com/_/alpine/). Alpine is based on [Alpine Linux](http://www.alpinelinux.org), lightweight Linux distribution based on [BusyBox](https://hub.docker.com/_/busybox/). The size of this image is very small, less than 30 MB!


## Getting The Image

This image is published in the [Docker Hub](https://hub.docker.com/r/cloudgen/alpine-nginx/). Simply run this command below to get it to your machine.

```Shell
docker pull cloudgen/alpine-nginx
```

Alternatively you can clone this repository and build the image using the `docker build` command.

## Build

The following is the build command

```Shell
docker build -t cloudgen/alpine-php8-nginx-1.23 .
```

## Configuration

The site data, config, and log data is configured to be located in a Docker volume so that it is persistent and can be shared by other containers or a backup container).

There is volume defined in this image `/etc/nginx/conf.d` that is shared with Nginx container. Please make sure both containers can access the directory. You can store the sites data to this directory.


## Run The Container

### Create and Run The Container

```Shell
 docker run -p "0.0.0.0:4040:80/tcp" --name alpinenginxphp  -v /data/conf.d:/etc/nginx/conf.d:rw -v /var/www:/var/www:rw  -d "cloudgen/alpine-php8-nginx-1.23:latest"
```
For MacOS
```Shell
 docker run -p "0.0.0.0:4040:80/tcp" --name alpinenginxphp  -v "/Users/{username}/conf.d:/etc/nginx/conf.d:rw" -v "/Users/{username}:/var/www:rw"  -d "cloudgen/alpine-php8-nginx-1.23:latest"
```


If you run and want to link Nginx container, make sure you created and run this PHP-FPM the container before running this Nginx container. Make sure the `/www` volume in PHP-FPM container is mapped.

 * The first `-p` argument maps the container's port 9000 to port 9000 on the host and used for communication between Nginx and PHP-FPM.
 * `--name` argument sets the name of the container, useful when starting and stopping the container.
 * The `-v` argument maps the `/data/nginx-conf.d` directory in the host to `/etc/nginx/conf.d` in the container with read/write access (rw).
 * `-d` argument runs the container as a daemon.

After starting the container, please setup the configuration by the followings:
```Shell
docker container exec -it alpinenginxphp /bin/ash
```

Then, you can see the login ash shell, type 
```Shell
cp /app/default.conf /etc/nginx/conf.d/
cp /app/index.php /var/www
exit
```

Restart the docker container:
```Shell
docker container restart alpinenginxphp
```

You can access the php-fpm example by:
```
http://localhost:4040
```

### Stopping The Container

```Shell
ddocker container stop alpinenginxphp
```
### Start The Container Again

```Shell
docker container start alpinenginxphp
```

## Alpine php-fpm
The docker image works well with https://hub.docker.com/r/cloudgen/alpine-php8-fpm/