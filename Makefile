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

# a development environment to run and test specific parts
.PHONY:login build deploy reset-nvidia

connect: build
	docker run -it ${PROJECT_REGISTRY} bash

reset-nvidia: ##@Environment Reset nvidia runtime through the commande sudo rmmod nvidia_uvm, see troubleshot section of the readme. Only works on nvidia GPU machine.
	sudo rmmod nvidia_uvm
	sudo modprobe nvidia_uvm