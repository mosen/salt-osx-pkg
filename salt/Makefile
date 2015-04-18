USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make
include ../include/python.make

TITLE=salt
REVERSE_DOMAIN=com.github.mosen.luggage.salt
TARBALL_LOCATION=https://pypi.python.org/packages/source/s/salt/salt-${PACKAGE_VERSION}.tar.gz#md5=64607e73055626509c59e51fe6feee88
TARBALL=salt.tar.gz
PACKAGE_VERSION=2014.7.2
PAYLOAD=\
	unpack-salt-${PACKAGE_VERSION} \
	build-salt-${PACKAGE_VERSION} \
	pack-Library-Python-${PYTHON_VERSION}-site-packages-salt \
	pack-usr-local-bin \
	pack-Library-LaunchDaemons-com.saltstack.salt.minion.plist \
	pack-script-postflight

unpack-salt-${PACKAGE_VERSION}:
	curl ${TARBALL_LOCATION} -o ${TARBALL}
	@sudo ${TAR} xzf salt.tar.gz

build-salt-${PACKAGE_VERSION}: unpack-salt-${PACKAGE_VERSION}
	cd salt-${PACKAGE_VERSION}; sudo python setup.py build

pack-Library-Python-${PYTHON_VERSION}-site-packages-salt: build-salt-${PACKAGE_VERSION} l_Python_${PYTHON_VERSION}_site-packages
	@sudo ${CP} -Rf salt-${PACKAGE_VERSION}/build/lib/salt ${WORK_D}/Library/Python/${PYTHON_VERSION}/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/${PYTHON_VERSION}/site-packages/salt
	@sudo chmod 755 ${WORK_D}/Library/Python/${PYTHON_VERSION}/site-packages/salt

pack-usr-local-bin: l_usr_local_bin
	@sudo ${CP} salt-${PACKAGE_VERSION}/build/scripts-${PYTHON_VERSION}/* ${WORK_D}/usr/local/bin
	@sudo chown root:wheel ${WORK_D}/usr/local/bin/*
	@sudo chmod 755 ${WORK_D}/usr/local/bin/*

pack-Library-LaunchDaemons-com.saltstack.salt.minion.plist: l_Library_LaunchDaemons
	@sudo ${CP} salt-${PACKAGE_VERSION}/pkg/darwin/com.saltstack.salt.minion.plist ${WORK_D}/Library/LaunchDaemons/com.saltstack.salt.minion.plist

# clean:
# 	rm -rf ./salt-${PACKAGE_VERSION}
# 	rm ${TARBALL}
# 	rm ${TITLE}-${PACKAGE_VERSION}.pkg

