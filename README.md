#### tomcat7-java7-vagrant-stack
### A single Ubuntu 14 VM on AWS provisioned using Vagrant, Puppet to host & run Java7,Tomcat7 & Mysql5

#### Purpose

If you need a ready java web app dev stack quickly, clone this repo, setup the conf files, do a "vagrant up".
You will have a running dev/test environment on AWS.

#### Prerequisite

AWS account : 
  * access and secret key
  * .pem or .ppk SSH key to access your AWS servers(you can create one on AWS)

#### How to setup...detais

###### AWS

- Signup at http://aws.amazon.com/console/.
- create a Ubuntu 14 based dev box.
    - create keypair, sec group, note down the subnet and other details.


###### Vagrant

- SSH into the Ubuntu dev box, run the foll

```
sudo apt-get update
wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb
sudo dpkg -i vag*.deb
sudo apt-get install make
sudo apt-get install git
sudo apt-get install gcc
```
- Setup AWS box for Vagrant
  - Refer https://github.com/mitchellh/vagrant-aws
```
vagrant plugin install vagrant-aws
vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
```

###### This stack 

- clone this repo and setup the config file

```
git clone --recursive https://github.com/charudath/tomcat7-java7-vagrant-stack
cd tomcat7-java7-vagrant-stack/
cp yourcert.pem . (copy your AWS SSH key here, MAKE SURE chmod 400 for pem !)
vi props.yml (update as below)
vagrant up
```

```
aws.access_key_id : "your API key"
aws.secret_access_key : "your API secret"
aws.keypair_name : "you keypair name as created in AWS"
aws.instance_type : "m3.large"
aws.ami : "ami-487a3920"
aws.region : "us-east-1"
aws.subnet_id : "an accessible subnet"
aws.security_groups : "you security group id as created in AWS"
override.ssh.username : "ubuntu"
override.ssh.private_key_path : "yourSSHKey.pem"
```


#### How to extend




