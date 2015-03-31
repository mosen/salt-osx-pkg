include /usr/local/share/luggage/luggage.make
include ../../../include/python.make

TITLE=pyzmq.macosx-py2.7-macosx
REVERSE_DOMAIN=com.github.mosen.luggage.pyzmq
PACKAGE_VERSION=14.5.0
TARBALL_LOCATION=https://pypi.python.org/packages/source/p/pyzmq/pyzmq-${PACKAGE_VERSION}.tar.gz#md5=8d3351a8ca2ca2a272a3f96bcb963e41

PAYLOAD=\
	pack-lib

pack-lib: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/pyzmq-${PACKAGE_VERSION}/build/lib.macosx-10.9-intel-2.7/zmq ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/zmq
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/zmq

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/pyzmq-${PACKAGE_VERSION}; python setup.py build 

unpack_tarball: pyzmq.tar.gz
	sudo ${TAR} xvf pyzmq.tar.gz -C ${SCRATCH_D}

pyzmq.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o pyzmq.tar.gz

