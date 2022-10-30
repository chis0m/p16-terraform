# create instance for jenkins
resource "aws_instance" "Jenkins" {
  ami                         = var.ubuntu_ami
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_1_id
  vpc_security_group_ids      = [var.compute_sg_id]
  associate_public_ip_address = true
  key_name                    = var.keypair

  tags = merge({ "Name" : "${var.project}-${var.workspace}-Jenkins-EC2" }, var.tags)
}


#create instance for sonbarqube
resource "aws_instance" "sonbarqube" {
  ami                         = var.ubuntu_ami
  instance_type               = "t2.medium"
  subnet_id                   = var.public_subnet_1_id
  vpc_security_group_ids      = [var.compute_sg_id]
  associate_public_ip_address = true
  key_name                    = var.keypair

  tags = merge({ "Name" : "${var.project}-${var.workspace}-SonarQube-EC2" }, var.tags)
}

# create instance for artifactory
resource "aws_instance" "artifactory" {
  ami                         = var.redhat_ami
  instance_type               = "t2.medium"
  subnet_id                   = var.public_subnet_1_id
  vpc_security_group_ids      = [var.compute_sg_id]
  associate_public_ip_address = true
  key_name                    = var.keypair


  tags = merge({ "Name" : "${var.project}-${var.workspace}-Artificatory-EC2" }, var.tags)
}
