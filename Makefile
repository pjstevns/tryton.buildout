
default: bin/python bin/buildout buildout

bin/python:
	virtualenv --no-site-packages --distribute .

bin/buildout: bin/python
	bin/easy_install zc.buildout

devel: bin/python bin/buildout
	test -d src || mkdir src
	bin/buildout -Nv -c devel.cfg

buildout:
	bin/buildout -Nv -c base.cfg

clean:
	rm -rf bin/ include/ lib/ eggs/ develop-eggs/
