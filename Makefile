PROJECT_NAME := "example4supervisor"
PKG := "$(PROJECT_NAME)"
#PKG_LIST := $(shell go list ${PKG}/... | grep -v /vendor/)
GO_FILES := $(shell find go-example -name '*.go' | grep -v /vendor/ | grep -v _test.go)

.PHONY: all dep lint vet test test-coverage build clean

all: build

dep: ## Get the dependencies
	@cd go-example && env GOPROXY=https://goproxy.io go mod download

lint: ## Lint Golang files
	@cd go-example && golint -set_exit_status ${PKG_LIST}

vet: ## Run go vet
	@cd go-example && go vet ${PKG_LIST}

test: ## Run unittests
	@cd go-example && go test -short ${PKG_LIST}

test-coverage: ## Run tests with coverage
	@cd go-example && go test -short -coverprofile cover.out -covermode=atomic ${PKG_LIST}
	@cd go-example && cat cover.out >> coverage.txt

build: dep ## Build the binary file
	@cd go-example && env GOPROXY=https://goproxy.io CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags "-s -w"
	@cd c-example && gcc -s hello.c -o hello
	@which upx && find go-example -type f -executable | xargs upx

clean: ## Remove previous build
	@find c-example go-example -type f -executable | xargs rm -f

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
