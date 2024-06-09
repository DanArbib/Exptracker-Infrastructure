#!/bin/bash

WORKSPACE="prod"
if [ "$#" -eq 1 ]; then
  WORKSPACE=$1
fi

terraform init
terraform workspace select -or-create "$WORKSPACE"
terraform apply -var-file $WORKSPACE.tfvars -auto-approve
