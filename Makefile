
default: bin/python bin/buildout buildout

bin/python:
	virtualenv --no-site-packages --distribute .

bin/buildout: bin/python
	bin/easy_install zc.buildout

devel: bin/python bin/buildout
	test -d src || mkdir src
	test -d src/tryton || hg clone http://hg.tryton.org/tryton src/tryton 
	test -d src/trytond || hg clone http://hg.tryton.org/trytond src/trytond 
	cd src && for module in `grep src/trytond_ ../devel.cfg|grep -v '#'|cut -f2 -d/|sed 's/trytond_//'`; do \
		test -d trytond_$$module || hg clone http://hg.tryton.org/modules/$$module trytond_$$module; \
	done
	bin/buildout -Nv -c devel.cfg

update:
	cd src/tryton && hg pull && hg merge || true
	cd src/trytond && hg pull && hg merge || true
	cd src && for module in `grep src/trytond_ ../devel.cfg|grep -v '#'|cut -f2 -d/`; do \
		( cd $$module && hg pull && hg update || true ); \
	done
	bin/buildout -Nv -c devel.cfg

buildout:
	bin/buildout -Nv -c base.cfg


clean:
	rm -rf bin/ include/ lib/ eggs/ develop-eggs/
