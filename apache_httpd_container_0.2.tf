provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "blubird_image" {
  name = "httpd:latest"
}

resource "docker_volume" "blubird_volume" {
  name = "blubird_volume"
}

resource "docker_container" "httpd" {
  name  = "blubird"
  image = "${docker_image.blubird_image.name}"
  volumes {
    volume_name = "${docker_volume.blubird_volume.name}"
	container_path = "/www/var/html"
  }
}