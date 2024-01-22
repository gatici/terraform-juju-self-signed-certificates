resource "juju_model" "test" {
  name = var.model_name
}

resource "juju_application" "self-signed-certificates" {
  name = "self-signed-certificates"
  model = juju_model.test.name

  charm {
    name = "self-signed-certificates"
    channel = var.channel
    base = "ubuntu@22.04"
  }

  units = 1
}
