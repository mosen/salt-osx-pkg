include /usr/local/share/luggage/luggage.make

TITLE=requests
REVERSE_DOMAIN=com.github.mosen.luggage.requests
TARBALL_LOCATION=https://pypi.python.org/packages/source/r/requests/requests-${PACKAGE_VERSION}.tar.gz#md5=25287278fa3ea106207461112bb37050
PACKAGE_VERSION=2.6.0
PAYLOAD=\
	pack-requests

l_Python: l_Library
	@sudo mkdir ${WORK_D}/Library/Python
	@sudo chown root:wheel ${WORK_D}/Library/Python
	@sudo chmod 755 ${WORK_D}/Library/Python

l_Python_2.7: l_Python
	@sudo mkdir ${WORK_D}/Library/Python/2.7
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7

l_Python_2.7_site-packages: l_Python_2.7
	@sudo mkdir ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages

pack-requests: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/requests-2.6.0/build/lib/requests ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/requests
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/requests

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/requests-2.6.0; sudo python setup.py build

unpack_tarball: requests.tar.gz
	sudo ${TAR} xvf requests.tar.gz -C ${SCRATCH_D}

requests.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o requests.tar.gz

