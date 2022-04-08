
REPO=blacktop/docker-idapro
ORG=blacktop
NAME=idapro
BUILD ?=$(shell cat LATEST)
LATEST ?=$(shell cat LATEST)

all: build size test

.PHONY: build
build: ## Build docker image
	docker build -t $(ORG)/$(NAME):$(BUILD) $(BUILD)

.PHONY: size
size: build ## Get built image size
ifeq "$(BUILD)" "$(LATEST)"
	sed -i.bu 's/docker%20image-.*-blue/docker%20image-$(shell docker images --format "{{.Size}}" $(ORG)/$(NAME):$(BUILD)| cut -d' ' -f1)-blue/' README.md
	sed -i.bu '/latest/ s/[0-9.]\{3,5\}MB/$(shell docker images --format "{{.Size}}" $(ORG)/$(NAME):$(BUILD))/' README.md
endif
	sed -i.bu '/$(BUILD)/ s/[0-9.]\{3,5\}MB/$(shell docker images --format "{{.Size}}" $(ORG)/$(NAME):$(BUILD))/' README.md

.PHONY: test
test: ## Test docker image
	echo "not implimented yet"

.PHONY: ssh
ssh: ## SSH into docker image
	@docker run --init -it --rm --entrypoint=bash $(ORG)/$(NAME):$(BUILD)

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help