resource "aws_security_group" "webserver_access" {
        name = "webserver_access"
        description = "allow ssh and http"

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
                from_port = 443
                to_port = 443
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }


}

resource "aws_instance" "webserver" {
  ami           = "ami-03f4878755434977f"
  availability_zone = "ap-south-1a"
  instance_type = "t2.micro"
  key_name = "full"
  user_data = "${file("install_all.sh")}"
  security_groups = ["${aws_security_group.webserver_access.name}"]
  tags = {
    Name  = "ec2 with security"
  }

}



