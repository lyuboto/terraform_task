provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_container" "httpd" {
  name  = "blubird"
  image = "httpd:latest"
  volumes {
    volume_name = "blubird_test"
    container_path = "/www/var/html"
  }
}