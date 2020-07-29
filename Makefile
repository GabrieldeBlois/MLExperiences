GREEN  := $(shell tput -Txterm setaf 2)
WHITE  := $(shell tput -Txterm setaf 7)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)
ARCH   := $(shell uname -m)

.PHONY:start stop clean restart tests stats teardown
start: ##@Start-and-stop Starts all the images contained by the docker-compose at once via docker-compose up without arguments
	docker-compose up

stop: ##@Start-and-stop Stops all the running containers with docker-compose down
	docker-compose down

restart: clean start

clean: stop ##@Environment Clean out temporary files, containers, etc

teardown: ##@Environment Completely remove any containers, images, leftovers on the system
	docker-compose down --rmi all

stats: ##@other Useful docker stats with formating
	@echo $(PROJECT_NAME)
	docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.Container}}"

help: ##@other Shows this help.
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

HELP_FUN = \
	%help; \
	while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
	print "usage: make [target]\n\n"; \
	for (sort keys %help) { \
		print "${WHITE}$$_:${RESET}\n"; \
		for (@{$$help{$$_}}) { \
			$$sep = " " x (32 - length $$_->[0]); \
			print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; \
	}; \
	print "\n"; }


# a development environment to run and test specific parts
.PHONY:start-d minio login build deploy portforward-es-data portforward-es-kibana connect-to-gcloud-project reset-nvidia
start-d: start

connect: build
	docker run -it ${PROJECT_REGISTRY} bash

reset-nvidia: ##@Environment Reset nvidia runtime through the commande sudo rmmod nvidia_uvm, see troubleshot section of the readme. Only works on nvidia GPU machine.
	sudo rmmod nvidia_uvm
	sudo modprobe nvidia_uvm