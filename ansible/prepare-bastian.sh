#!/bin/bash

echo "[bastion]" > inventory
cut -d: -f2 ../eks-infra/EC2_IPs.txt >> inventory.ini

ansible-playbook -i inventory.ini prepare-bastian-playbook.yaml
