#!/bin/bash
rm -rf packer_cache

export PACKER_LOG=1
export CI=true
export GITLAB_SSH_PATH=~/.ssh/gitlab_sa
export INSPEC_PROFILE=enterprisedb
export INSPEC_SA_USERNAME=adopt_sa
export INSPEC_SA_TOKEN=_REDACTED_
export INSPEC_PROFILES_PATH=chef/inspec_profiles
export JFROG_CLI_HOME_DIR=~/.jfrog
export CI_COMMIT_REF_NAME=working
export OUTPUT_DIR=artifacts
export BUILD_ARGS="-force -on-error=ask"
export VIRTUALBOX_VMS_DIR=/u01/VirtualBoxVMs
export OUTPUT_DIR=/u01/artifacts

export OS_VERSION=6
export OS=rhel
export BASE_POSTFIX=base
export RULE=vbox
export POSTFIX=base
unset DB

packer build \
  -force \
  -on-error=abort \
  -var-file=common/vsphere.variables.json \
  -var-file=common/{,linux/{,redhat/{,6/{,}}}}variables.json \
  -only=vbox-rhel-base \
  common/linux/redhat/template.json
