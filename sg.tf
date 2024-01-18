
resource "aws_security_group" "common" {
  name        = "${var.name}-common"
  description = "mke cluster common rules"
  vpc_id      = module.vpc.vpc_id

  tags = merge({
    stack = var.name
    role  = "sg"
    unit  = "common"
  }, var.tags)


}

locals {
  // SG Rules have conflicts between cidr and self, so we have to build lists for each case
  // This should not create any ordering issues as the two sets of rules are almost
  // always separated in firewall building.
  ingress_ipv4_self    = [for i in var.firewall.ingress_ipv4 : i if i.self]
  ingress_ipv4_notself = [for i in var.firewall.ingress_ipv4 : i if !i.self]
  egress_ipv4_self     = [for i in var.firewall.egress_ipv4 : i if i.self]
  egress_ipv4_notself  = [for i in var.firewall.egress_ipv4 : i if !i.self]
}

resource "aws_security_group_rule" "in_ipv4_self" {
  count = length(local.ingress_ipv4_self)

  description = local.ingress_ipv4_self[count.index].description
  type        = "ingress"
  self        = true

  security_group_id = aws_security_group.common.id

  from_port = local.ingress_ipv4_self[count.index].from_port
  protocol  = local.ingress_ipv4_self[count.index].protocol
  to_port   = local.ingress_ipv4_self[count.index].to_port
}

resource "aws_security_group_rule" "in_ipv4" {
  count = length(local.ingress_ipv4_notself)

  description = local.ingress_ipv4_notself[count.index].description
  type        = "ingress"

  security_group_id = aws_security_group.common.id

  cidr_blocks = local.ingress_ipv4_notself[count.index].cidr_blocks
  from_port   = local.ingress_ipv4_notself[count.index].from_port
  protocol    = local.ingress_ipv4_notself[count.index].protocol
  to_port     = local.ingress_ipv4_notself[count.index].to_port
}

resource "aws_security_group_rule" "out_ipv4_self" {
  count = length(local.egress_ipv4_self)

  description = local.egress_ipv4_self[count.index].description
  type        = "egress"
  self        = true

  security_group_id = aws_security_group.common.id

  from_port = local.egress_ipv4_self[count.index].from_port
  protocol  = local.egress_ipv4_self[count.index].protocol
  to_port   = local.egress_ipv4_self[count.index].to_port
}

resource "aws_security_group_rule" "out_ipv4" {
  count = length(local.egress_ipv4_notself)

  description = local.egress_ipv4_notself[count.index].description
  type        = "egress"

  security_group_id = aws_security_group.common.id

  cidr_blocks = local.egress_ipv4_notself[count.index].cidr_blocks
  from_port   = local.egress_ipv4_notself[count.index].from_port
  protocol    = local.egress_ipv4_notself[count.index].protocol
  to_port     = local.egress_ipv4_notself[count.index].to_port
}
