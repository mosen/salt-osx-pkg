include /usr/local/share/luggage/luggage.make
include ../../../include/python.make

TITLE=MarkupSafe.macosx-py2.7
REVERSE_DOMAIN=com.github.mosen.luggage.MarkupSafe
PACKAGE_VERSION=0.23
TARBALL_LOCATION=https://pypi.python.org/packages/source/M/MarkupSafe/MarkupSafe-${PACKAGE_VERSION}.tar.gz
PAYLOAD=\
	pack-MarkupSafe


pack-MarkupSafe: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/MarkupSafe-${PACKAGE_VERSION}/build/lib.macosx-10.9-intel-2.7/MarkupSafe ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/MarkupSafe
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/MarkupSafe

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/MarkupSafe-${PACKAGE_VERSION}; sudo python setup.py build 

unpack_tarball: MarkupSafe.tar.gz
	sudo ${TAR} xvf MarkupSafe.tar.gz -C ${SCRATCH_D}

MarkupSafe.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o MarkupSafe.tar.gz

