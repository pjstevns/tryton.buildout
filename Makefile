
default: bin/python bin/buildout
	bin/buildout -Nv

bin/python:
	virtualenv --clear .

bin/buildout: bin/python
	bin/python ./bootstrap.py

devel: bin/python bin/buildout
	test -d src || mkdir src
	bin/buildout -Nv -c devel.cfg

clean:
	rm -rf bin/ include/ lib/ eggs/ develop-eggs/
