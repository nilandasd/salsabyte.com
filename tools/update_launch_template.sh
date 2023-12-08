#!/bin/bash

SG_ID=$(aws ec2 describe-security-groups \
  --filters Name=group-name,Values=ec2 \
  --query 'SecurityGroups[0].GroupId' \
  --output text)

BACKEND_AMI=`aws ec2 describe-images   \
  --filters "Name=name,Values=backend" \
  --query 'Images[0].[ImageId]' \
  --output text`

aws ec2 create-launch-template-version \
  --launch-template-name backend \
  --launch-template-data "{
      \"ImageId\": \"$BACKEND_AMI\",
      \"InstanceType\": \"t3.micro\",
      \"NetworkInterfaces\": [
        {
          \"Groups\": [\"$SG_ID\"]
        }
      ]
    }" \
