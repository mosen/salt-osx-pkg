# Makefile for creating a SaltStack OS X Package.
# Depends on Xcode (or command line tools)
# Depends on fpm

PREFIX=/usr/local/salt
PKGTITLE="salt"
PKGVERSION=1.0.0
PKGID=com.github.mosen.salt
PKGROOT:=$(shell pwd)/pkgroot
PKGROOTS:=$(shell pwd)/pkgroots
DISTROOT:=$(shell pwd)/distroot

BASE="saltpkg"
TMP:=$(shell mktemp -d /tmp/${BASE}.XXXXXX)
CACHE=./cache
BUILD=./build
LIBTOOL_FLAGS="-inst-prefix-dir $(PKGROOT)"
PKG_CONFIG_PATH=$(PKGROOT)$(PREFIX)/lib/pkgconfig

OPENSSL_URL="https://www.openssl.org/source/openssl-1.0.2g.tar.gz"
OPENSSL_URL_SHA256="https://www.openssl.org/source/openssl-1.0.2g.tar.gz.sha256"
LIBSODIUM_URL="https://download.libsodium.org/libsodium/releases/LATEST.tar.gz"
SODIUM_VERSION=1.0.10
LIBYAML_URL="http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz"
ZEROMQ_URL="http://download.zeromq.org/zeromq-4.1.4.tar.gz"

# Broken
verify:
	curl ${OPENSSL_URL_SHA256} -o ${CACHE}/openssl.sha256
	openssl dgst -sha256 -verify ${CACHE}/openssl.sha256 ${CACHE}/openssl.tar.gz

# 'fetch' targets 
$(CACHE)/openssl.tar.gz:
	@mkdir -p $(CACHE)
	curl $(OPENSSL_URL) -o $(CACHE)/openssl.tar.gz

$(CACHE)/libsodium.tar.gz:
	@mkdir -p $(CACHE)
	curl $(LIBSODIUM_URL) -o $(CACHE)/libsodium.tar.gz

$(CACHE)/yaml.tar.gz:
	@mkdir -p $(CACHE)
	curl $(LIBYAML_URL) -o $(CACHE)/yaml.tar.gz

$(CACHE)/zeromq.tar.gz:
	@mkdir -p $(CACHE)
	curl $(ZEROMQ_URL) -o $(CACHE)/zeromq.tar.gz

fetch: $(CACHE)/openssl.tar.gz $(CACHE)/libsodium.tar.gz $(CACHE)/yaml.tar.gz $(CACHE)/zeromq.tar.gz

# 'unpack' targets 
$(CACHE)/openssl-1.0.2g: fetch
	cd $(CACHE); tar zxvf openssl.tar.gz 

$(CACHE)/libsodium-1.0.10: fetch
	cd $(CACHE); tar zxvf libsodium.tar.gz

$(CACHE)/yaml-0.1.5: fetch
	cd $(CACHE); tar zxvf yaml.tar.gz

$(CACHE)/zeromq-4.1.4: fetch
	cd $(CACHE); tar zxvf zeromq.tar.gz

unpack: $(CACHE)/openssl-1.0.2g $(CACHE)/libsodium-1.0.10 $(CACHE)/yaml-0.1.5 $(CACHE)/zeromq-4.1.4

# 'configure' targets
build_openssl: unpack
	cd $(CACHE)/openssl-1.0.2g; ./configure --prefix=$(PREFIX) darwin64-x86_64-cc
	cd $(CACHE)/openssl-1.0.2g; make && make INSTALL_PREFIX="$(PKGROOTS)/openssl" install
	
$(PKGROOTS)/sodium32/libsodium.dylib: $(CACHE)/libsodium-1.0.10
	cd $(CACHE)/libsodium-1.0.10; make clean
	cd $(CACHE)/libsodium-1.0.10; CFLAGS='-arch i386' LDFLAGS='-Xlinker -install_name -Xlinker $(PREFIX)/lib/libsodium.13.dylib' ./configure --prefix=$(PREFIX)
	cd $(CACHE)/libsodium-1.0.10; make && make DESTDIR="$(PKGROOTS)/sodium32" install

$(PKGROOTS)/sodium64/libsodium.dylib: $(CACHE)/libsodium-1.0.10
	cd $(CACHE)/libsodium-1.0.10; make clean
	cd $(CACHE)/libsodium-1.0.10; CFLAGS='-arch x86_64' LDFLAGS='-Xlinker -install_name -Xlinker $(PREFIX)/lib/libsodium.13.dylib' ./configure --prefix=$(PREFIX)
	cd $(CACHE)/libsodium-1.0.10; make && make DESTDIR="$(PKGROOTS)/sodium64" install

# TODO: ZeroMQ not linking to libsodium from sodium target
build_zeromq:
	cd $(CACHE)/zeromq-4.1.4; ./autogen.sh && PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) ./configure --prefix=$(PREFIX) --with-libsodium && make -j 4
	cd $(CACHE)/zeromq-4.1.4; make DESTDIR="$(PKGROOTS)/zeromq" install

lipo_libsodium: $(PKGROOTS)/sodium32$(PREFIX)/lib/libsodium.dylib $(PKGROOTS)/sodium64$(PREFIX)/lib/libsodium.dylib
	@mkdir -p $(PKGROOTS)/sodium/usr/local/salt
	cp -Rf $(PKGROOTS)/sodium64/* $(PKGROOTS)/sodium
	lipo -arch i386 $(PKGROOTS)/sodium32$(PREFIX)/lib/libsodium.18.dylib -arch x86_64 $(PKGROOTS)/sodium64$(PREFIX)/lib/libsodium.18.dylib -create -output $(PKGROOTS)/sodium$(PREFIX)/lib/libsodium.18.dylib	 
	lipo -arch i386 $(PKGROOTS)/sodium32$(PREFIX)/lib/libsodium.a -arch x86_64 $(PKGROOTS)/sodium64$(PREFIX)/lib/libsodium.a -create -output $(PKGROOTS)/sodium$(PREFIX)/lib/libsodium.a	 
	

build: ${CACHE}/openssl-1.0.2g/libssl.a lipo_libsodium
	
$(DISTROOT)/libsodium-$(SODIUM_VERSION).pkg: lipo_libsodium
	pkgbuild --root $(PKGROOTS)/sodium --identifier com.github.mosen.libsodium --version "$(SODIUM_VERSION)" --ownership recommended $(DISTROOT)/libsodium-$(SODIUM_VERSION).pkg	

$(DISTROOT)/OpenSSL-1.0.2g.pkg: build_openssl
	pkgbuild --root $(PKGROOTS)/openssl --identifier com.github.mosen.openssl --version "1.0.2g" --ownership recommended $(DISTROOT)/OpenSSL-1.0.2g.pkg

$(DISTROOT)/zeromq-4.1.4.pkg: build_zeromq
	pkgbuild --root $(PKGROOTS)/zeromq --identifier com.github.mosen.zeromq --version "4.1.4" --ownership recommended $(DISTROOT)/zeromq-4.1.4.pkg


deps: $(DISTROOT)/libsodium-$(SODIUM_VERSION).pkg $(DISTROOT)/OpenSSL-1.0.2g.pkg $(DISTROOT)/zeromq-4.1.4.pkg
  
pips:
	@mkdir -p $(DISTROOT)
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen apache-libcloud
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen jinja2
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen markupsafe
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen msgpack-python
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen pycrypto
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen requests
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen backports.ssl_match_hostname
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen backports_abc
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen tornado
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen singledispatch
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen certifi
	fpm -s python -t osxpkg -p $(DISTROOT) --osxpkg-identifier-prefix com.github.mosen salt 
 
dist: deps pips
	productbuild --distribution Distribution.xml --package-path $(DISTROOT) salt.pkg
