resource "docker_image" "helm" {
  name = "alpine/helm:3.3.4"
}

resource "docker_container" "helm_cli" {
  name       = "${var.cluster_name}-helm3-cli"
  image      = docker_image.helm.latest
  entrypoint = [
    "tail",
    "-f",
    "/dev/null"
  ]
  must_run   = true

  volumes {
    host_path      = var.eks_kubeconfig
    container_path = "/root/.kube/config"
  }

  volumes {
    host_path      = "/root/.helm"
    container_path = "/root/.helm"
  }

  volumes {
    host_path      = "/usr/sbin/aws-iam-authenticator"
    container_path = "/usr/sbin/aws-iam-authenticator"
  }
}