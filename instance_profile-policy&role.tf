# IAM Role
resource "aws_iam_role" "role" {
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
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
      }
    ]
  })
}

# Instance Profile
resource "aws_iam_instance_profile" "instance_profile" {
  name = "bastion_instance_profile"
  role = aws_iam_role.role.name
}

#iam_role_policy_attachment for ssm-access
resource "aws_iam_role_policy_attachment" "ssm_access" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}