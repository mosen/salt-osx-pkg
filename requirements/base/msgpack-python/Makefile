include /usr/local/share/luggage/luggage.make

TITLE=msgpack-python.macosx-py2.7
REVERSE_DOMAIN=com.github.mosen.luggage.msgpack-python
TARBALL_LOCATION=https://pypi.python.org/packages/source/m/msgpack-python/msgpack-python-0.4.6.tar.gz#md5=8b317669314cf1bc881716cccdaccb30
PACKAGE_VERSION=0.4.6
PAYLOAD=\
	pack-msgpack

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

pack-msgpack: distutils_build l_Python_2.7_site-packages
	@sudo ${CP} -Rf ${SCRATCH_D}/msgpack-python-0.4.6/build/lib.macosx-10.9-intel-2.7/msgpack ${WORK_D}/Library/Python/2.7/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/2.7/site-packages/msgpack
	@sudo chmod 755 ${WORK_D}/Library/Python/2.7/site-packages/msgpack

distutils_build: unpack_tarball
	cd ${SCRATCH_D}/msgpack-python-0.4.6; sudo python setup.py build

unpack_tarball: msgpack-python.tar.gz
	sudo ${TAR} xvf msgpack-python.tar.gz -C ${SCRATCH_D}

msgpack-python.tar.gz: Makefile
	curl ${TARBALL_LOCATION} -o msgpack-python.tar.gz

