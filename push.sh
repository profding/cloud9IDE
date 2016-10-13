#!/bin/bash
group=

forone()
{
user=$1
port=${user:5:4}
if [ $port -lt 2000 ];then
port=`expr 2000 + $port`
fi
echo $port
su $1 -l -c "cp /cloud9/configs/standalone.js ~/.cloud9/configs"
su $1 -l -c "cp /cloud9/configs/client-default.js ~/.cloud9/configs"
su $1 -l -c "cp /cloud9/plugins/c9.logger ~/.cloud9/plugins -r"
su $1 -l -c "mkdir ~/.sel4log"
su $1 -l -c "nohup ~/.cloud9/server.js -l 0.0.0.0 -p $port -w ~/$group-refos -a $user:$user &"
#su $1 -l -c " cp /.c9 ~/ -r"
}

userlist=`cat $1`
group=`basename $1`
for a in $userlist
do
forone $a
done
