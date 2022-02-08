default: mod_refresh build run

PORT_DEFAULT=8080
MODULE_NAME=my_project_ci_cd
EXECUTITION_FILE=main
DOCKER_HUB_NAME=tss45elcity
REPOSITORY=repo_1
IMAGE_NAME=hello_ci_cd_go
IMAGE_VERSION=v1
FULL_DOCKER_CONTAINER_NAME=$(DOCKER_HUB_NAME)/$(REPOSITORY):$(IMAGE_NAME)_$(IMAGE_VERSION)

module_init: main.go
	go mod init $(MODULE_NAME)

mod_refresh: go.mod
	go mod tidy

build: main.go go.mod
	CGO_ENABLED=0
	GOOS=linux
	gofmt -w ./
	go build -o ./$(EXECUTITION_FILE) ./

test: main.go go.mod main_test.go
	go test -v ./...

run: ./main
	./main $(PORT_DEFAULT)

docker_build: Dockerfile go.mod Makefile main_test.go main.go
	sudo docker build -f Dockerfile -t $(FULL_DOCKER_CONTAINER_NAME) .

docker_push:
	#docker login --username=$(DOCKER_USER) --password=$(DOCKER_PASS) $(DOCKER_HOST)
	sudo docker push $(FULL_DOCKER_CONTAINER_NAME)

docker_run:
	sudo docker run --rm -d -p 8886:8080 $(FULL_DOCKER_CONTAINER_NAME)