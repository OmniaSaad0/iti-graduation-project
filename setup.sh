#!/bin/bash

set -euo pipefail

# -------- CONFIG --------
EKS_DIR="eks-infra"
ANSIBLE_DIR="ansible"
EC2_IP_FILE="$EKS_DIR/EC2_IPs.txt"
SSH_KEY="$HOME/.ssh/key.pem"
REMOTE_USER="ubuntu"
REMOTE_PATH="iti-graduation-project/gitops-infra"
# ------------------------

echo_step() {
    echo -e "\n - $1"
}

error_exit() {
    echo "x $1"
    exit 1
}

# -------- Step 1: Terraform in eks-infra --------
[[ -d "$EKS_DIR" ]] || error_exit "Directory '$EKS_DIR' not found."

echo_step "Changing to $EKS_DIR and applying Terraform..."
cd "$EKS_DIR"
terraform init
terraform apply -auto-approve
cd - > /dev/null


# -------- Step 2: Prepare bastion --------
[[ -d "$ANSIBLE_DIR" ]] || error_exit "Directory '$ANSIBLE_DIR' not found."
cd "$ANSIBLE_DIR"

[[ -f "prepare-bastian.sh" ]] || error_exit "'prepare-bastian.sh' not found."

echo_step "Running Ansible preparation script..."
bash "prepare-bastian.sh"

cd - > /dev/null


# -------- Step 3: Extract public IP --------
[[ -f "$EC2_IP_FILE" ]] || error_exit "File '$EC2_IP_FILE' not found."

PUBLIC_IP=$(cat "$EC2_IP_FILE" )

[[ -n "$PUBLIC_IP" ]] || error_exit "Could not extract public IP from '$EC2_IP_FILE'."
echo_step " Extracted EC2 public IP: $PUBLIC_IP"

# -------- Step 4: SSH and run remote Terraform --------
[[ -f "$SSH_KEY" ]] || error_exit "SSH key '$SSH_KEY' not found."
chmod 400 "$SSH_KEY"

echo_step "Connecting to EC2 and applying remote Terraform..."
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$REMOTE_USER@$PUBLIC_IP" bash <<EOF
    set -e
    echo "Inside bastian host..."
    cd "$REMOTE_PATH" || { echo "Remote path '$REMOTE_PATH' not found."; exit 1; }
    terraform init
    terraform apply -auto-approve

    cd ../argo-config
    # kubectl apply -f argo-cm.yaml
    kubectl apply -f argocd.yaml
EOF



echo_step " All steps completed successfully!"
