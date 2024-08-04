resource "aws_instance" "necesse" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

#   instance_market_options {
#     market_type = "spot"
#     spot_options {
#       max_price                      = 0.03
#       instance_interruption_behavior = "stop"
#       spot_instance_type             = "persistent"
#     }
#   }

  tags = {
    Name = "necesseServer"
    # env_s3bucket = aws_s3_bucket.bucket.id
    dns_hostname = "necesse"
    dns_zone     = var.hosted_zone
  }

  vpc_security_group_ids = [aws_security_group.necesse_security.id]
  iam_instance_profile   = aws_iam_instance_profile.necesse_profile.id

  user_data_base64            = base64encode(data.template_file.user_data.rendered)
  user_data_replace_on_change = true
}

resource "aws_route53_record" "necesse" {
  type = "A"
  zone_id = data.aws_route53_zone.rgrs_zone.id
  name = "necesse"
  ttl = 300
  records = [aws_instance.necesse.public_ip]
}

data "template_file" "user_data" {
  template = "${path.module}/userdata.sh"
  vars = {
    GAMENAME = "${var.game_name}"
  }
}