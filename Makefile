NPM_EXECUTABLE_HOME := node_modules/.bin

PATH := ${NPM_EXECUTABLE_HOME}:${PATH}

test: deps
	@mocha --require coffee-errors --compilers coffee:coffee-script "$@"

dev: build
	@coffee -wc --bare -o lib src/*.coffee

build:
	@find src -name '*.coffee' | xargs coffee -c -o lib

clean:
	@rm -fr lib/

deps:

.PHONY: all
