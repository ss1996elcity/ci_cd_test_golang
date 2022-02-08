default: mod_refresh build run

PORT_DEFAULT=8080
MODULE_NAME=my_project_ci_cd
EXECUTITION_FILE=main
REGISTRY=tss45elcity/repo_1
IMAGE_NAME=hello_ci_cd_go
IMAGE_VERSION=v1
IMAGE_TAG=$(IMAGE_NAME):$(IMAGE_VERSION)

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
	docker build -f Dockerfile -t $(REGISTRY)/$(IMAGE_TAG) .

docker_push:
	docker push $(REGISTRY)/$(IMAGE_TAG)