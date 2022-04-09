
REPO=blacktop/docker-idapro
ORG=blacktop
NAME=idapro
BUILD ?=$(shell cat LATEST)
LATEST ?=$(shell cat LATEST)

IDAPW ?=$(shell cat ida.pw)

all: build size test

.PHONY: build
build: ## Build IDA Free docker image
	docker build -t $(ORG)/$(NAME):$(BUILD) $(BUILD)

.PHONY: build-pro
build-pro: ## Build IDA Pro docker image
	docker build --build-arg IDAPW=${IDAPW} -t $(ORG)/$(NAME):$(BUILD) pro

.PHONY: build-reg
build-reg: ## Build registered IDA Pro docker image
	docker build --build-arg IDAPW=${IDAPW} -t $(ORG)/$(NAME):$(BUILD) -f pro/Dockerfile.reg pro

.PHONY: size
size: build ## Get built image size
ifeq "$(BUILD)" "$(LATEST)"
	sed -i.bu 's/docker%20image-.*-blue/docker%20image-$(shell docker images --format "{{.Size}}" $(ORG)/$(NAME):$(BUILD)| cut -d' ' -f1)-blue/' README.md
	sed -i.bu '/latest/ s/[0-9.]\{3,5\}MB/$(shell docker images --format "{{.Size}}" $(ORG)/$(NAME):$(BUILD))/' README.md
endif
	sed -i.bu '/$(BUILD)/ s/[0-9.]\{3,5\}MB/$(shell docker images --format "{{.Size}}" $(ORG)/$(NAME):$(BUILD))/' README.md

.PHONY: test
test: ## Test docker image
	@echo "not implimented yet"

.PHONY: run
run: stop-client ## Run IDA Pro client
	@docker run --init -it --name $(NAME) \
             --cpus="2" \
             --memory="4g" \
             -e MAXMEM=4G \
             -e DISPLAY=host.docker.internal:0 \
			 -v `pwd`:/data \
             $(ORG)/$(NAME):$(BUILD)

.PHONY: socat
socat: ## Start socat
	open -a XQuartz
	socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$$DISPLAY\"

.PHONY: ssh
ssh: ## SSH into docker image
	@docker run --init -it --rm -v $(PWD)/data:/data --entrypoint=bash -e DISPLAY=host.docker.internal:0 $(ORG)/$(NAME):$(BUILD)

.PHONY: stop-client
stop-client: ## Kill running client container
	@docker rm -f $(NAME) || true

clean: stop-all ## Clean docker image and stop all running containers
	docker rmi $(ORG)/$(NAME):$(BUILD) || true

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help