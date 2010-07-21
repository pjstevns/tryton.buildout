
default: bin/python bin/buildout buildout

bin/python:
	virtualenv --no-site-packages .

bin/buildout: bin/python
	bin/easy_install zc.buildout

buildout:
	bin/buildout -v
