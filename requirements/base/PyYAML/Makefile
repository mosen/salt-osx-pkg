include /usr/local/share/luggage/luggage.make
include ../../../include/python.make

TITLE=PyYAML.macosx-py2.7
REVERSE_DOMAIN=com.github.mosen.luggage.PyYAML
PACKAGE_VERSION=3.11
TARBALL_LOCATION=https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.11.tar.gz#md5=f50e08ef0fe55178479d3a618efe21db

PAYLOAD=\
	pack-lib


pack-lib: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/PyYAML-${PACKAGE_VERSION}/build/lib.macosx-10.9-intel-2.7/yaml ${WORK_D}/Library/Python/2.7/site-packages
	@sudo ${CP} ${SCRATCH_D}/PyYAML-${PACKAGE_VERSION}/build/lib.macosx-10.9-intel-2.7/_yaml.so ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/yaml
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/yaml

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/PyYAML-${PACKAGE_VERSION}; sudo python setup.py build 

unpack_tarball: PyYAML.tar.gz
	sudo ${TAR} xvf PyYAML.tar.gz -C ${SCRATCH_D}

PyYAML.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o PyYAML.tar.gz

