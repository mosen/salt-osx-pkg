#!/usr/bin/env bash

# Build Dependencies:
# brew install swig
# brew install libyaml
# brew install openssl
# brew install zeromq


BUILD_DIR=`pwd`

# Base SaltStack Requirements
for dir in $( ls $BUILD_DIR/requirements/base ); do
    cd $BUILD_DIR/requirements/base/$dir
    make pkg
    mv *.pkg $BUILD_DIR/pkgsource
done

# ZeroMQ Transport Requirements
for dir in $( ls $BUILD_DIR/requirements/zeromq ); do
    cd $BUILD_DIR/requirements/zeromq/$dir
    make pkg
    mv *.pkg $BUILD_DIR/pkgsource
done

# RAET Transport Requirements
for dir in $( ls $BUILD_DIR/requirements/raet ); do
    cd $BUILD_DIR/requirements/raet/$dir
    make pkg
    mv *.pkg $BUILD_DIR/pkgsource
done

# salt-cloud Requirements
for dir in $( ls $BUILD_DIR/requirements/cloud ); do
    cd $BUILD_DIR/requirements/cloud/$dir
    make pkg
    mv *.pkg $BUILD_DIR/pkgsource
done

cd $BUILD_DIR/salt && make pkg
mv $BUILD_DIR/salt/*.pkg $BUILD_DIR/pkgsource

# Synthesize the Distribution
productbuild --synthesize \
    --package pkgsource/Jinja2.macosx-py2.7-2.7.3.pkg \
    --package pkgsource/M2Crypto.macosx-py2.7-0.22.3.pkg \
    --package pkgsource/MarkupSafe.macosx-py2.7-0.23.pkg \
    --package pkgsource/msgpack-python.macosx-py2.7-0.4.6.pkg \
    --package pkgsource/pycrypto.macosx-py2.7-2.6.1.pkg \
    --package pkgsource/PyYAML.macosx-py2.7-3.11.pkg \
    --package pkgsource/pyzmq.macosx-py2.7-14.5.0.pkg \
    --package pkgsource/requests.macosx-py2.7-2.6.0.pkg \
    --package pkgsource/salt.macosx-py2.7-2014.7.2.pkg \
    Distribution.xml

# Build the Distribution
productbuild --distribution ./Distribution.xml --package-path ./pkgsource ./salt-2014.7.2.pkg