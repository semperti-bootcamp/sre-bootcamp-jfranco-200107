#yum groupinstall "Development Tools"
wget https://downloads.sourceforge.net/project/sshpass/sshpass/1.06/sshpass-1.06.tar.gz
tar zxvf sshpass-1.06.tar.gz
cd sshpass-1.06
./configure
make
sudo make install
#chmod +x node_configure.sh