#!/bin/sh

add_user() {

useradd -d /home/$1 -s /bin/bash -m $1
chmod 700 /home/$1
echo $1:$1|chpasswd

su $1 -l -c "ssh-keygen -q -N $1 -f /home/$1/.ssh/id_rsa"
cp /home/$1/.ssh/id_rsa.pub keydir/$1.pub

}

USERLIST=`cat $1`
for stu in $USERLIST
do
	add_user $stu
done
