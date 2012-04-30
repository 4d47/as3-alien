
# shortcuts, shortcuts ...
# it's all just shortcuts

all: build
	ant -f build/build.xml

clean:
	ant -f build/build.xml clean
	find -name '*.swf' -exec rm {} \;
	rm -rf bin

build:
	git submodule update --init

test-integration:
	ant -f build/build.xml -Dfile test/integration/my/external/AsyncExternalInterfaceTest.as -Dbin test/integration/my/external/ -Ddebug=true build-swf
	open http://localhost:8080/test/integration/my/external/AsyncExternalInterfaceTest.html
	python -m SimpleHTTPServer 8080

.PHONY: all clean test-integration
