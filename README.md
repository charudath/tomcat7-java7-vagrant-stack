#### tomcat7-java7-vagrant-stack
### A single Ubuntu 14 VM on AWS provisioned using Vagrant, Puppet to host & run Java7,Tomcat7 & Mysql5

#### Purpose

If you need a ready java web app dev stack quickly, clone this repo, setup the conf files, do a "vagrant up".
You will have a running dev/test environment on AWS or local depneding on your vagrant configuration.

#### Prerequisite

AWS account : 
  access and secret key
  .pem or .ppk SSH key to access your AWS servers(you can create one on AWS)

#### How To...crisp

- git clone --recursive https://github.com/charudath/tomcat7-java7-vagrant-stack
- cd tomcat7-java7-vagrant-stack/
- cp yourcert.pem .
- vi props.yml 

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
- vagrant up


