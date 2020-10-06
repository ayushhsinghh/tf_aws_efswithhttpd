resource "aws_instance" "webserverInstance" {
  ami           = "ami-005956c5f0f757d37"
  instance_type = "t2.micro"
  key_name	   = "TerraformTest"
  subnet_id = "subnet-daaba8b2"
  availability_zone = "ap-south-1a"
  security_groups	   = ["${aws_security_group.allow_HTTP.id}"]
  user_data	   = <<-EOF
			       #! /bin/bash
			       sudo su - root
			       yum install httpd -y
			       yum install php -y
			       yum install git -y
			       yum update -y
			       yum install amazon-efs-utils
			       service httpd start
			       chkconfig --add httpd
			       efs_id="${aws_efs_file_system.efsbackup.id}"
			       mount -t efs $efs_id:/ /var/www/html
			       echo $efs_id:/ /var/www/html efs defaults,_netdev 0 0 >> /etc/fstab
			       rm -rf /var/www/html/*
                   git clone https://github.com/cybergodayush/WebsiteBasic.git /var/www/html/

	EOF
  tags = {
    Name = "webserverInstance"
  }
}