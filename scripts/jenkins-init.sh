#!/bin/bash


vgchange -ay

DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then 
  
  DEVICENAME=`echo "${DEVICE}" | awk -F '/' '{print $3}'`
  DEVICEEXISTS=''
  while [[ -z $DEVICEEXISTS ]]; do
    echo "checking $DEVICENAME"
    DEVICEEXISTS=`ls -asl /dev/disk/by-uuid/ | grep "$DEVICENAME"`
    if [[ -z $DEVICEEXISTS ]]; then
      sleep 15
    fi
  done
	pvcreate ${DEVICE}
	vgcreate data ${DEVICE}
	lvcreate --name volume1 -l 100%FREE data
	mkfs.ext4 /dev/data/volume1
fi
mkdir -p /var/lib/jenkins
echo '/dev/data/volume1 /var/lib/jenkins ext4 defaults 0 0' >> /etc/fstab
mount /var/lib/jenkins


wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo "deb http://pkg.jenkins.io/debian-stable binary/" >> /etc/apt/sources.list
apt-get update
apt-get install -y jenkins unzip docker.io


usermod -G docker jenkins
systemctl enable docker
service docker start
service jenkins restart


wget -q https://bootstrap.pypa.io/get-pip.py
python get-pip.py
python3 get-pip.py
rm -f get-pip.py

pip install awscli


cd /usr/local/bin
wget -q https://releases.hashicorp.com/terraform/0.11.5/terraform_0.11.5_linux_amd64.zip
unzip terraform_0.11.5_linux_amd64.zip

apt-get clean
rm terraform_0.11.5_linux_amd64.zip
