# Python install locations
PYTHON_VERSION=2.7

l_Python: l_Library
	@sudo mkdir ${WORK_D}/Library/Python
	@sudo chown root:wheel ${WORK_D}/Library/Python
	@sudo chmod 755 ${WORK_D}/Library/Python

l_Python_${PYTHON_VERSION}: l_Python
	@sudo mkdir ${WORK_D}/Library/Python/${PYTHON_VERSION}
	@sudo chown root:wheel ${WORK_D}/Library/Python/${PYTHON_VERSION}
	@sudo chmod 755 ${WORK_D}/Library/Python/${PYTHON_VERSION}

l_Python_${PYTHON_VERSION}_site-packages: l_Python_${PYTHON_VERSION}
	@sudo mkdir ${WORK_D}/Library/Python/${PYTHON_VERSION}/site-packages
	@sudo chown root:wheel ${WORK_D}/Library/Python/${PYTHON_VERSION}/site-packages
	@sudo chmod 755 ${WORK_D}/Library/Python/${PYTHON_VERSION}/site-packages
