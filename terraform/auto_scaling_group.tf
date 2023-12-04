resource "aws_autoscaling_group" "backend" {
  name     = "backend"
  min_size = 1
  max_size = 3

  health_check_type = "EC2"

  vpc_zone_identifier = [
    aws_subnet.private_us_east_1a.id,
    aws_subnet.private_us_east_1b.id
  ]

  target_group_arns = [aws_lb_target_group.salsabyte.arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.backend.id
      }
    }
  }
}

resource "aws_autoscaling_policy" "backend" {
  name                   = "backend"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.backend.name

  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80.0
  }
}

resource "aws_launch_template" "backend" {
  name                   = "backend"
  image_id               = data.aws_ami.al2023.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ec2.id]
  update_default_version = true
}

data "aws_ami" "al2023" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = ["backend"]
  }
}
