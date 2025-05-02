#!/bin/bash

echo "[bastion]" > inventory.ini
cat ../eks-infra/EC2_IPs.txt >> inventory.ini

ansible-playbook -i inventory.ini prepare-bastian-playbook.yaml
