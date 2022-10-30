resource "aws_iam_role" "ec2_role_trust_relationship" {
  name = "ec2_role_trust_relationship"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = merge({ "Name" : "${var.project}-${var.workspace}-AssumeRole" }, var.tags)
}

resource "aws_iam_policy" "ec2_role_policy" {
  name        = "ec2_instance_role_policy"
  description = "A test policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]

  })
  tags = merge({ "Name" : "${var.project}-${var.workspace}-AssumeRolePolicy" }, var.tags)
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ec2_role_trust_relationship.name
  policy_arn = aws_iam_policy.ec2_role_policy.arn
}

resource "aws_iam_instance_profile" "ip" {
  name = "aws_instance_profile_test"
  role = aws_iam_role.ec2_role_trust_relationship.name
}
