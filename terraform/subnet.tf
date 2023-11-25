resource "aws_subnet" "private_us_east_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = local.zone_a

  tags = merge(
    local.common_tags,
    {
      Name = "private-${local.zone_a}"
    }
  )
}

resource "aws_subnet" "private_us_east_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = local.zone_b

  tags = merge(
    local.common_tags,
    {
      Name = "private-${local.zone_b}"
    }
  )
}

resource "aws_subnet" "public_us_east_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = local.zone_a
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "public-${local.zone_a}"
    }
  )
}

resource "aws_subnet" "public_us_east_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = local.zone_b
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "public-${local.zone_b}"
    }
  )
}

