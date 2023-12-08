#!/bin/bash

aws autoscaling start-instance-refresh \
  --auto-scaling-group-name backend \
  --preferences '{"InstanceWarmup": 60}' \
  --desired-configuration '{
    "LaunchTemplate": {
      "LaunchTemplateName": "backend",
      "Version": "$Latest"
    }
  }'
