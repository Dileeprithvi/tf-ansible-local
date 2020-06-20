#provider block

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

    

#Create EC2 instance
resource "aws_instance" "TestInstance1" {
  ami             = "ami-09d95fab7fff3776c"
  instance_type   = "${var.instance_type}"
  count = 1
  key_name = "awskey1"
  vpc_security_group_ids = [
      "${aws_security_group.webSG.id}",
  ]
  tags = {
    Name = "Test"
  }

provisioner "local-exec" {
    command = <<EOD
cat <<EOF > aws_hosts
[dev]
${aws_instance.TestInstance1.0.public_ip}
EOF
EOD
}

  provisioner "local-exec" {
command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key ./awskey1.pem -i '${self.public_ip},' master.yml"  
}
}


#resources

#Create Security Group  
resource "aws_security_group" "webSG" {
  name        = "webSG"
  description = "Allow ssh  inbound traffic"
  vpc_id      = "vpc-f0525289"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }
}



#outputs

output "TestInstance1_pub_ip" {
    value = "${aws_instance.TestInstance1.0.public_ip}"
}

output "TestInstance1_id" {
    value = "${aws_instance.TestInstance1.0.id}"
}
