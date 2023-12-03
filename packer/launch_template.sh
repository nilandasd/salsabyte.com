#!/bin/bash

# First get the ami id of the ami named backend
# Get the ec2 security group id
# AWS EC2 Launch Template Configuration
# ami_id="ami-0123456789abcdef0"
# security_group_id="sg-0123456789abcdef0"
echo LAUNCH TEMPLATE

# Create Launch Template
#template_id=$(aws ec2 create-launch-template \
#   --launch-template-name "backend" \
#   --instance-type "t3.micro" \
#   --image-id "$ami_id" \
#   --security-group-ids "$security_group_id" \
#   --output json | jq -r '.LaunchTemplate.LaunchTemplateId')

# echo "Launch Template created with ID: $template_id"

