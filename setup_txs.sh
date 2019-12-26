#!/bin/sh
VERSION_FILE=./VERSION
INSTALL_DIR=/opt/s-tip
COMMON_DIR=/home/stip/stip-common
SCRIPTS_DIR=$COMMON_DIR/install_scripts

# git clone
git clone https://github.com/s-tip/stip-txs.git
chown -R stip:stip stip-txs

## apt install
apt install -y gunicorn3

## pip install
pip3 install supervisor>=4.1.0
pip3 install gunicorn>=19.7.1
pip3 install libtaxii
pip3 install opentaxii==0.1.7

# copy TXS setting
mkdir -p $INSTALL_DIR/txs
mkdir -p /etc/supervisor/conf.d
mkdir -p /var/log/supervisor
cp -pr $COMMON_DIR/stip-txs/conf $INSTALL_DIR/txs
cp -p $COMMON_DIR/stip-txs/init.d/supervisord.conf /etc/supervisor/
cp -p $COMMON_DIR/stip-txs/init.d/conf.d/stip-taxii-server.ini /etc/supervisor/conf.d/
cp -pr $COMMON_DIR/stip-txs/init.d/conf.d/cert /etc/supervisor/conf.d/
ln -s $COMMON_DIR/stip-txs/src $INSTALL_DIR/txs/src
cp -p $VERSION_FILE $INSTALL_DIR/txs/version
chown -R stip:stip $INSTALL_DIR/txs
