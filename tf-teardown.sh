#!/bin/bash

WORKSPACE="prod"
if [ "$#" -eq 1 ]; then
  WORKSPACE=$1
fi

terraform workspace select "$WORKSPACE"
terraform destroy -var-file $WORKSPACE.tfvars -auto-approve
