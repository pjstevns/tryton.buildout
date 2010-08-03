
default: bin/python bin/buildout buildout

bin/python:
	virtualenv --no-site-packages .

bin/buildout: bin/python
	bin/easy_install zc.buildout

devel:
	test -d src/trytond || hg clone http://hg.tryton.org/trytond src/trytond
	cd src && for module in `grep src/ ../devel.cfg|grep -v tryton|cut -f2 -d/`; do \
		test -d $$module || hg clone http://hg.tryton.org/modules/$$module ; \
	done
	bin/buildout -v -c devel.cfg

update:
	cd src/trytond && hg pull && hg merge || true
	cd src && for module in `grep src/ ../devel.cfg|grep -v tryton|cut -f2 -d/`; do \
		( cd $$module && hg pull && hg merge || true ); \
	done
	bin/buildout -Nv -c devel.cfg

buildout:
	bin/buildout -v
