#!/bin/bash
kops create cluster --name=kops.udaymac.xyz --zones=us-east-1a,us-east-1b \
--state=s3://kops-state-v2 --node-count=1 \
--node-size=t3.small --master-size=t3.medium \
--node-volume-size=8 --master-volume-size=8 --dns-zone=kops.udaymac.xyz