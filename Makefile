
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
	ant -f build/build.xml -Dfile test/integration/alien/ExternalInterface2Test.as -Dbin test/integration/alien/ -Ddebug=true build-swf
	open http://localhost:8080/test/integration/alien/ExternalInterface2Test.html
	python -m SimpleHTTPServer 8080

.PHONY: all clean test-integration
