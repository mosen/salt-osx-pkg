# salt-osx-pkg

SaltStack OSX Binary Distribution Package for OS X

Currently, SaltStack lacks a native packaging format for OSX.
You can install it through `pip` or through `brew`, but you need a compiler.

Having a compiler on every minion isn't always practical.


## Dependencies

The build process has the following dependencies:

- Xcode or Command Line Tools
- Homebrew (brew.sh)
- The Luggage [https://github.com/unixorn/luggage]
- SWIG via Homebrew `brew install swig`
- libyaml via Homebrew `brew install libyaml`
- OpenSSL via Homebrew `brew install openssl`

## Building

At the moment, only part of the build process is done, by executing

    ./build.sh
    
In this repository.