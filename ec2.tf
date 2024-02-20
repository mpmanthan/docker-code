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
  key_name = "aws_key_pair.docker.docker-key"
  user_data = "${file("install_all.sh")}"
  security_groups = ["${aws_security_group.webserver_access.name}"]
  tags = {
    Name  = "ec2 with security"
  }

}

resource "aws_key_pair" "docker" {
  key_name   = "docker-key"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "dockerkey" {
  content  = tls_private_key.rsa.private_key.pem
  filename = "docker_key"
}

