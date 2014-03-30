#!/bin/bash -ex

# Work in progress: create a list of commands necessary to get Stackage
# up-and-running on a freshly installed Debian-based system (includin Ubuntu).

# Quick start:
# wget -O - https://raw.github.com/fpco/stackage/master/debian-bootstrap.sh | bash -ex

sudo apt-get update
sudo apt-get install -y build-essential libncurses-dev git libgmp3c2 libgmp3-dev zlib1g-dev libedit2 libedit-dev freeglut3-dev libglu1-mesa-dev libglib2.0-dev libcairo2-dev libpango1.0-dev libgtk2.0-dev zip libdevil-dev llvm
wget http://www.haskell.org/ghc/dist/7.4.2/ghc-7.4.2-x86_64-unknown-linux.tar.bz2
tar jxfv ghc-7.4.2-x86_64-unknown-linux.tar.bz2
cd ghc-7.4.2
./configure --prefix=/opt/ghc-7.4.2
sudo make install
echo 'export PATH=/opt/ghc-7.4.2/bin:~/.cabal/bin:$PATH' >> ~/.bashrc
export PATH=/opt/ghc-7.4.2/bin:~/.cabal/bin:$PATH
cd ..
wget http://hackage.haskell.org/packages/archive/cabal-install/1.16.0.2/cabal-install-1.16.0.2.tar.gz
tar zxfv cabal-install-1.16.0.2.tar.gz
cd cabal-install-1.16.0.2/
bash bootstrap.sh
cd ..
git clone --recursive https://github.com/fpco/stackage
cd stackage
cabal update
cabal install

stackage select && \
    stackage check && \
    stackage build && \
    stackage test
