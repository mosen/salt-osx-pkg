include /usr/local/share/luggage/luggage.make
include ../../../include/python.make

TITLE=raet
REVERSE_DOMAIN=com.github.mosen.luggage.raet-py2.7
PACKAGE_VERSION=0.6.3
TARBALL_LOCATION=https://pypi.python.org/packages/source/r/raet/raet-${PACKAGE_VERSION}.tar.gz
PAYLOAD=\
	pack-raet

pack-raet: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/raet-${PACKAGE_VERSION}/build/lib/raet ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/raet
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/raet

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/raet-${PACKAGE_VERSION}; sudo python setup.py build

unpack_tarball: raet.tar.gz
	sudo ${TAR} xvf raet.tar.gz -C ${SCRATCH_D}

raet.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o raet.tar.gz