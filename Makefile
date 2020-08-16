DOMAIN = "proyecto-django.dev"
ARGS = $(filter-out $@,$(MAKECMDGOALS))

all: start

start:
	docker-compose -f docker-compose.yml up -d nginx-proxy
	$(MAKE) logs

stop:
	docker-compose -f docker-compose.yml -f docker-compose.tests.yml stop

restart:
	docker-compose -f docker-compose.yml restart

delete:
	docker-compose -f docker-compose.yml -f docker-compose.tests.yml -f docker-compose.tools.yml down

migrate:
	docker-compose -f docker-compose.yml run --rm proyecto-django /entrypoint.sh run-migrations

tests:
	docker-compose -f docker-compose.tests.yml run --rm proyecto-django-tests /entrypoint.sh run-tests

build:
	docker-compose -f docker-compose.yml -f docker-compose.tests.yml build

build-nocache:
	docker-compose -f docker-compose.yml build --no-cache

status:
	docker-compose -f docker-compose.yml -f docker-compose.tests.yml -f docker-compose.tools.yml ps

bash:
	docker-compose -f docker-compose.yml run --rm proyecto-django bash

shell:
	docker-compose -f docker-compose.yml run --rm proyecto-django python manage.py shell

attach:
	docker attach `docker container inspect proyecto-django -f '{{.Id}}'`

logs:
	docker-compose -f docker-compose.yml logs --tail 250 -f ${ARGS}

delete_images:
	docker-compose -f docker-compose.yml -f docker-compose.tests.yml -f docker-compose.tools.yml down --rmi local

backup:
	docker-compose -f docker-compose.yml -f docker-compose.tools.yml run backup

restore:
	$(MAKE) stop
	docker-compose -f docker-compose.yml -f docker-compose.tools.yml run restore

certs:
	mkcert -cert-file ./certs/${DOMAIN}.crt -key-file ./certs/${DOMAIN}.key ${DOMAIN}

install_certs:
	mkcert -install

%:
	@:

.PHONY: % certs
