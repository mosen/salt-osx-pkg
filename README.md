# salt-osx-pkg

## Will be deprecated

For Salt 2016.03 there is a package build script included in the salt source.
SaltStack will also release a native package.

## Overview

SaltStack OSX Binary Distribution Package for OS X

Currently, SaltStack lacks a native package for OS X.
You can install it through `pip` or through `brew`, but you need a compiler such as Xcode command line tools.

Having a compiler on every minion isn't always practical, and installing Homebrew everywhere isn't always desired.

## Dependencies

To build the minion package we make use of some manual compilation and jordan sissel's excellent [fpm](https://github.com/jordansissel/fpm)
We will prefix everything to `/usr/local/salt` to avoid collisions with anything symlinked from Homebrew.
Python packages are installed into system python. Technically it would be cleaner to create a new `site-packages` and add
this to the python path. Maybe for the next release.

To build the package, you will need:

- Xcode or Xcode command line tools for the compiler.
- [fpm](https://github.com/jordansissel/fpm) to package the python dependencies.

## Manual Build Instructions

### Dynamic Libraries

#### OpenSSL

M2Crypto depends on OpenSSL, so that needs to be built first.

- Download the latest OpenSSL tarball
- Run configure with the following options:

        $ ./configure --prefix=/path/to/openssl/pkgroot/usr/local/salt darwin64-x86_64-cc
        $ make
        $ make install
    
- Fix the DYLIB_INSTALL_NAME using `install_name_tool`.
- Fix the pkgconfig

#### libsodium + ZeroMQ

ZeroMQ requires libsodium.

- Download the latest libsodium tarball [https://download.libsodium.org/libsodium/releases/LATEST.tar.gz](https://download.libsodium.org/libsodium/releases/LATEST.tar.gz).
- libsodium doesn't support building a universal binary so we have to compile i386 and x64 then lipo them together.

        $ CFLAGS='-arch i386' LDFLAGS='-Xlinker -install_name -Xlinker /usr/local/salt/lib/libsodium.13.dylib' ./configure --prefix=/pkgroot/libsodium_i386
        $ make && make install
        $ make clean
        $ CFLAGS='-arch x86_64' LDFLAGS='-Xlinker -install_name -Xlinker /usr/local/salt/lib/libsodium.13.dylib' ./configure --prefix=/pkgroot/libsodium_x64
        $ make && make install
        
- Lipo the i386/x64 libsodium together

- Download ZeroMQ tarball
- Configure with libsodium

#### LibYAML

- Download and unpack latest [LibYAML](http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz)
- Configure and build into `/usr/local/salt` prefix:

### Dynamically linked python extensions

In order to stop some python packages dynamically linking to the wrong library, I unpack their source and configure
them manually. There might be a pip flag for cython compilation options, not sure.

#### M2Crypto

#### pyyaml

#### pyzmq




### Pure python extensions

Pure python extensions can be directly downloaded and packaged via fpm, eg:

        $ fpm -s python -t osxpkg --osxpkg-identifier-prefix com.github.mosen <pip name>
         
These python packages are required:

- apache-libcloud
- jinja2
- markupsafe
- msgpack-python
- pycrypto
- requests
- backports.ssl_match_hostname
- backports_abc
- tornado
- singledispatch
- salt
- certifi

## Wrapping up in distribution

All that remains is to wrap all of the packages into a single Distribution.
For the moment I've done this manually using Packages.

        