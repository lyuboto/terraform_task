variable "docker_container_name" {}
variable "docker_volume_name" {}
variable "docker_network_name" {}
variable "docker_image_name" {
  default = "httpd:latest"
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "docker_image" {
  name = var.docker_image_name
}

resource "docker_network" "docker_network" {
  name = var.docker_network_name
}

resource "docker_volume" "docker_volume" {
  name = var.docker_volume_name
}

resource "docker_container" "docker_container" {
  name  = var.docker_container_name
  image = docker_image.docker_image.name
  volumes {
    volume_name    = docker_volume.docker_volume.name
    container_path = "/var/www/html"
  }
  networks_advanced {
    name = docker_network.docker_network.name
  }
  ports {
    internal = "80"
    external = "8080"
  }
  restart = "always"
}
