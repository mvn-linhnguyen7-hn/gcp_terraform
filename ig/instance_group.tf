
resource "google_compute_region_instance_group_manager" "appserver" {
  name = "appserver-igm"

  base_instance_name = "app"
  # zone     = "europe-west1-c"
  region                     = "europe-west1"
  distribution_policy_zones  = ["europe-west1-a", "europe-west1-c"]

  named_port {
    name = "http"
    port = 80
  }

  version {
    instance_template  = google_compute_instance_template.instance_template.id
  }

  target_size  = 2

}
