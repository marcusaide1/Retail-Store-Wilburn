resource "aws_security_group" "catalog" {
  name        = "${var.environment_name}-catalog-sg"
  description = "Catalog service SG"
  vpc_id      = module.vpc.inner.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.inner.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = module.tags.result
}

resource "aws_security_group" "orders" {
  name        = "${var.environment_name}-orders-sg"
  description = "Orders service SG"
  vpc_id      = module.vpc.inner.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.inner.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = module.tags.result
}

resource "aws_security_group" "checkout" {
  name        = "${var.environment_name}-checkout-sg"
  description = "Checkout service SG"
  vpc_id      = module.vpc.inner.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.inner.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = module.tags.result
}

