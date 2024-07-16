resource "aws_launch_template" "server" {
  name_prefix   = "server-"
  image_id      = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  key_name      = var.SSH_KEYS

  network_interfaces {
    subnet_id       = var.PRIVATE_SUBNET_ID
    security_groups = [var.SERVER_SECURITY_GROUP_ID]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "server-instance"
    }
  }

  user_data = base64encode(<<EOF
  #!/bin/bash
  sudo apt-get update -y && sudo apt-get upgrade -y
  sudo apt-get install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -y
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  sudo groupadd docker
  sudo usermod -aG docker $USER
  sudo systemctl restart docker
  sudo docker run -it -d --rm \
  -p ${var.SERVER_PORT}:${var.SERVER_PORT} \
  -e HOST_NAME=localhost
  ${var.SERVER_IMAGE}:${var.SHARED_TAG}"
  EOF
  )
}


resource "aws_autoscaling_group" "server_asg" {
  launch_template {
    id      = aws_launch_template.server.id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.PRIVATE_SUBNET_ID]
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1

  lifecycle {
    create_before_destroy = true
  }
}

