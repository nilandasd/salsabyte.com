#!/bin/bash

aws autoscaling start-instance-refresh \
  --auto-scaling-group-name backend \
  --desired-configuration '{
    "LaunchTemplate": {
      "LaunchTemplateName": "backend"
    }
  }' \
  --preferences '{ "AutoRollback": true }'
