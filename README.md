# Docker development environment for Django

## What is this?

This is a docker development environment focused on Python / Django.

A `Makefile` is provided, it contains targets for the most common tasks.

## Why should I use it?

It provides a well tested and fully functional working development environment for Python / Django projects. It also has some extra features, like:

* HTTPS by default (with valid certificates it you run `make install_certs`).
* Commands for creating and restoring backups.
* Commands for managing the containers and images.

## How to use

Do these only once:

1. Add `127.0.0.1    proyecto-django.dev` to your `/etc/hosts`.
3. Run `make certs`.
2. Run `make install_certs`.

Do these every time you want to work on your project:

1. Run `make start`.
2. Your Django project is ready! Open your browser and go to `https://proyecto-django.dev`.

## All targets

* `make start` - Start the development environment (it will start all containers of the project).
* `make stop` - Stop the development environment (it will stop all containers of the project).
* `make restart` - Restart the development environment (it will restart all containers of the project).
* `make delete` - Delete all containers of the project.
* `make migrate` - It will apply all pending migrations.
* `make tests` - It will run the tests.
* `make build` - It will (re)build all images of the project.
* `make build-nocache` - Same as `make build`, but without using cache.
* `make status` - It will show the current status of the containers of the project.
* `make bash` - It will open a bash shell inside Django's container.
* `make shell` - It will open Django's shell/REPL inside the container.
* `make attach` - It will attach to Django's container (useful for debugging).
* `make logs` - It will tail the logs (last 250 lines) of all containers of the project.
* `make delete_images` - It will delete all images of the project.
* `make backup` - It will create a backup of the database inside the `./data/backup/` folder.
* `make restore` - It will restore a backup to the database from the `./data/backup/` folder.
* `make certs` - It will generate SSL certificates for the NGINX container.
* `make install_certs` - It will install the root CA certs (this is required only if you want )