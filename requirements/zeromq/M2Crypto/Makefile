include /usr/local/share/luggage/luggage.make
include ../../../include/python.make

TITLE=M2Crypto
REVERSE_DOMAIN=com.github.mosen.luggage.M2Crypto
TARBALL_LOCATION=https://pypi.python.org/packages/source/M/M2Crypto/M2Crypto-${PACKAGE_VERSION}.tar.gz
PACKAGE_VERSION=0.22.3
PAYLOAD=\
	pack-lib
OPENSSL_INCLUDE=/usr/local/Cellar/openssl/1.0.2a-1/include
OPENSSL_LIB=/usr/local/Cellar/openssl/1.0.2a-1/lib

pack-lib: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/M2Crypto-0.22.3/build/lib.macosx-10.9-intel-2.7/M2Crypto ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/M2Crypto
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/M2Crypto

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/M2Crypto-${PACKAGE_VERSION}; sudo python setup.py build_ext -I ${OPENSSL_INCLUDE} -L ${OPENSSL_LIB}
	cd ${SCRATCH_D}/M2Crypto-${PACKAGE_VERSION}; sudo python setup.py build

unpack_tarball: M2Crypto.tar.gz
	sudo ${TAR} xvf M2Crypto.tar.gz -C ${SCRATCH_D}

M2Crypto.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o M2Crypto.tar.gz

