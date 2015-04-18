include /usr/local/share/luggage/luggage.make
include ../../../include/python.make

TITLE=libnacl
REVERSE_DOMAIN=com.github.mosen.luggage.libnacl-py2.7
PACKAGE_VERSION=1.4.2
TARBALL_LOCATION=https://pypi.python.org/packages/source/l/libnacl/libnacl-${PACKAGE_VERSION}.tar.gz
PAYLOAD=\
	pack-libnacl

pack-libnacl: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/libnacl-${PACKAGE_VERSION}/build/lib/libnacl ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/libnacl
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/libnacl

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/libnacl-${PACKAGE_VERSION}; sudo python setup.py build

unpack_tarball: libnacl.tar.gz
	sudo ${TAR} xvf libnacl.tar.gz -C ${SCRATCH_D}

libnacl.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o libnacl.tar.gz

