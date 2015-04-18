include /usr/local/share/luggage/luggage.make
include ../../../include/python.make

TITLE=ioflo
REVERSE_DOMAIN=com.github.mosen.luggage.ioflo-py2.7
PACKAGE_VERSION=1.2.1
TARBALL_LOCATION=https://pypi.python.org/packages/source/i/ioflo/ioflo-${PACKAGE_VERSION}.tar.gz
PAYLOAD=\
	pack-ioflo

pack-ioflo: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/ioflo-${PACKAGE_VERSION}/build/lib/ioflo ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/ioflo
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/ioflo

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/ioflo-${PACKAGE_VERSION}; sudo python setup.py build

unpack_tarball: ioflo.tar.gz
	sudo ${TAR} xvf ioflo.tar.gz -C ${SCRATCH_D}

ioflo.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o ioflo.tar.gz