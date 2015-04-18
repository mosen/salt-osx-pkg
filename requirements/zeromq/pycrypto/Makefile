include /usr/local/share/luggage/luggage.make
include ../../../include/python.make

TITLE=pycrypto
REVERSE_DOMAIN=com.github.mosen.luggage.pycrypto
PACKAGE_VERSION=2.6.1
TARBALL_LOCATION=https://pypi.python.org/packages/source/p/pycrypto/pycrypto-${PACKAGE_VERSION}.tar.gz
PAYLOAD=\
	pack-lib


pack-lib: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/pycrypto-${PACKAGE_VERSION}/build/lib.macosx-10.9-intel-2.7/Crypto ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/Crypto
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/Crypto

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/pycrypto-${PACKAGE_VERSION}; sudo python setup.py build 

unpack_tarball: pycrypto.tar.gz
	sudo ${TAR} xvf pycrypto.tar.gz -C ${SCRATCH_D}

pycrypto.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o pycrypto.tar.gz

