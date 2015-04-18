include /usr/local/share/luggage/luggage.make
include ../../../include/python.make

TITLE=Jinja2
REVERSE_DOMAIN=com.github.mosen.luggage.Jinja2
PACKAGE_VERSION=2.7.3
TARBALL_LOCATION=https://pypi.python.org/packages/source/J/Jinja2/Jinja2-${PACKAGE_VERSION}.tar.gz
PAYLOAD=\
	pack-Jinja2

pack-Jinja2: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/Jinja2-${PACKAGE_VERSION}/build/lib/Jinja2 ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/Jinja2
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/Jinja2

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/Jinja2-${PACKAGE_VERSION}; sudo python setup.py build 

unpack_tarball: Jinja2.tar.gz
	sudo ${TAR} xvf Jinja2.tar.gz -C ${SCRATCH_D}

Jinja2.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o Jinja2.tar.gz

