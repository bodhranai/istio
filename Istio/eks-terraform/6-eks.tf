resource "aws_iam_role" "prod-westus1-eks" {
  name = "eks-cluster-prod-westus1-eks"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo_amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.prod-westus1-eks.name
}

resource "aws_eks_cluster" "prod-westus1-eks" {
  name     = "prod-westus1-eks"
  version  = "1.32"
  role_arn = aws_iam_role.prod-westus1-eks.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_us_west_1a.id,
      aws_subnet.private_us_west_1c.id,
      aws_subnet.public_us_west_1a.id,
      aws_subnet.public_us_west_1c.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.demo_amazon_eks_cluster_policy]
}
