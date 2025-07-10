resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.tags,
    { Name = "${var.name}-vpc" }
  )
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = merge(
    var.tags,
    { Name = "${var.name}-public-subnet-${count.index}" }
  )
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.azs, count.index)
  tags = merge(
    var.tags,
    { Name = "${var.name}-private-subnet-${count.index}" }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    var.tags,
    { Name = "${var.name}-igw" }
  )
}

resource "aws_nat_gateway" "this" {
  count         = var.enable_nat_gateway ? length(aws_subnet.public) : 0
  allocation_id = element(var.eip_allocation_ids, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags = merge(
    var.tags,
    { Name = "${var.name}-natgw-${count.index}" }
  )
}
