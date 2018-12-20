cat /var/jenkins_home/secrets/initialAdminPassword 
cd /usr/sbin/
ls
exit
cd tmp/
ls
ssi -i jenkins-access production@172.19.0.2
ssh -i jenkins-access production@172.19.0.2
exit
cd /var/log/
ls
exit
