GO ?= go
TOOLS_MOD := -modfile=go.tools.mod

## test: run tests for the plugin and MCP server
test:
	$(GO) test ./...
	$(MAKE) -C mcp-server test GO="$(GO)"

## install-tools: download tool dependencies for both Go modules
install-tools:
	$(GO) mod download $(TOOLS_MOD)
	$(MAKE) -C mcp-server install-tools GO="$(GO)"

## fmt: format both Go modules using golangci-lint
fmt:
	$(GO) tool $(TOOLS_MOD) golangci-lint fmt
	$(MAKE) -C mcp-server fmt GO="$(GO)"

## lint: check both Go modules using golangci-lint
lint:
	$(GO) tool $(TOOLS_MOD) golangci-lint run
	$(MAKE) -C mcp-server lint GO="$(GO)"

.PHONY: test install-tools fmt lint
