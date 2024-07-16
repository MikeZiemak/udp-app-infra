SHARED_TAG = "0.3-amd64"

SERVER_STARTUP_SCRIPT = <<EOF
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

CLIENT_STARTUP_SCRIPT = <<EOF
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
  -p ${var.CLIENT_PORT}:${var.CLIENT_PORT} \
  -e BACKEND_HOST=backend.udpapp.internal
  ${var.CLIENT_IMAGE}:${var.SHARED_TAG}
  EOF
