# Create public subnets
resource "aws_subnet" "public" {
  count                   = local.subnetCount
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags                    = merge({ "Name" = "${var.project}-${var.workspace}-PublicSubnet-${count.index + 1}" }, var.tags)
}

# Create private subnets
resource "aws_subnet" "proxy-server-private" {
  count                   = local.subnetCount
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.proxy_private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags                    = merge({ "Name" : "${var.project}-${var.workspace}-ProxyServer-PrivateSubnet-${count.index + 1}" }, var.tags)
}

resource "aws_subnet" "web-server-private" {
  count                   = local.subnetCount
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.web_private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags                    = merge({ "Name" : "${var.project}-${var.workspace}-WebServer-PrivateSubnet-${count.index + 1}" }, var.tags)
}

resource "aws_subnet" "database-private" {
  count                   = local.subnetCount
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.database_private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags                    = merge({ "Name" : "${var.project}-${var.workspace}-Database-PrivateSubnet-${count.index + 1}" }, var.tags)
}
