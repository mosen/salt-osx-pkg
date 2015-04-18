include /usr/local/share/luggage/luggage.make
include ../../../include/python.make

TITLE=apache-libcloud
REVERSE_DOMAIN=com.github.mosen.luggage.apache-libcloud
PACKAGE_VERSION=0.17.0
TARBALL_LOCATION=https://pypi.python.org/packages/source/a/apache-libcloud/apache-libcloud-${PACKAGE_VERSION}.tar.gz
PAYLOAD=\
	pack-apache-libcloud

pack-apache-libcloud: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/apache-libcloud-${PACKAGE_VERSION}/build/lib/libcloud ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/libcloud
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/libcloud

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/apache-libcloud-${PACKAGE_VERSION}; sudo python setup.py build

unpack_tarball: apache-libcloud.tar.gz
	sudo ${TAR} xvf apache-libcloud.tar.gz -C ${SCRATCH_D}

apache-libcloud.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o apache-libcloud.tar.gz

