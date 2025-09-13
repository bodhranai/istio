# provider "helm" {
#   kubernetes {
#     host                   = aws_eks_cluster.prod-westus1-eks.endpoint
#     cluster_ca_certificate = base64decode(aws_eks_cluster.prod-westus1-eks.certificate_authority[0].data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.prod-westus1-eks.id]
#       command     = "aws"
#     }
#   }
# }

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}
