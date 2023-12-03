packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "backend" {
  ami_name      = "backend"
  instance_type = "t3.micro"
  region        = "us-east-1"
  ssh_username  = "ec2-user"

source_ami_filter {
    filters = {
      name                = "al2023-ami-2023*x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners = ["137112412989"]
  }

  tags = {
    Owner = "packer"
    Name = "backend"
    Project = "salsabyte"
  }
}

build {
  sources = ["source.amazon-ebs.backend"]

  provisioner "file" {
    destination = "/tmp/"
    source      = "./packer/backend.service"
  }

  provisioner "file" {
    destination = "/tmp/"
    source      = "./package.json"
  }

  provisioner "file" {
    destination = "/tmp/"
    source      = "./package-lock.json"
  }

  provisioner "file" {
    destination = "/tmp/"
    source      = "./tsconfig.json"
  }

  provisioner "file" {
    destination = "/tmp/src"
    source      = "./src"
  }

  provisioner "file" {
    destination = "/tmp/"
    source      = "./Dockerfile"
  }

  provisioner "shell" {
    script = "packer/bootstrap.sh"
  }
}

