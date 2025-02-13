resource "aws_iam_role" "Jenkins-master-role" {
  name = "Jenkins-master-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "Administrationaccess" {
  depends_on = [ aws_iam_role.Jenkins-master-role ]
  role       = aws_iam_role.Jenkins-master-role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "Jenkins-master-instance-role" {
  depends_on = [ aws_iam_role.Jenkins-master-role, aws_iam_role_policy_attachment.Administrationaccess ]
  name = "Jenkins-master-full-access-profile"
  role = aws_iam_role.Jenkins-master-role.name
}
