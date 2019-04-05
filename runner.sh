#!/usr/bin/env bash

set -x
set -e

here=$(dirname $0)

GROUP_PLAYBOOK=$1
INVENTORY="$here/inventory/inventory"
ANSIBLE_STDOUT_CALLBACK=debug
PYTHONUNBUFFERED=1
EXTRA_VARS="ansible_python_interpreter=/usr/bin/python3"

# More debug options from ansible docs about auto-provisioning...
# (mostly disables built-in checks and overrides some defaults)
# (broken across lines so all the options are easier to see):
# PYTHONUNBUFFERED=1
# ANSIBLE_FORCE_COLOR=true
# ANSIBLE_HOST_KEY_CHECKING=false
# ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=60s'
# ansible-playbook
# --private-key=/home/someone/.vagrant.d/insecure_private_key
# --user=vagrant
# --connection=ssh
# --limit='machine1'
# --inventory=/inventory/vagrant_ansible_inventory
# playbook.yml

# "debug" below formats output as properly indented/pretty printed.
# You can also replace "debug" with "yaml" for a different view.
# For details of all stdout callbacks, see:
# https://docs.ansible.com/ansible/2.5/plugins/callback.html
# and/or
# ansible-doc -t callback -l

# The following assumes you are testing per-host playbooks and the
# host(s) you are testing are a prefix of the playbook name.
# e.g. if your host name is "webby" and you test playbook "web",
#      that's a valid prefix match ("web" is a prefix of "webby")
#      or, you can use direct names: deploy to mailmash using mailmash.yml
ansible-playbook --verbose --inventory $INVENTORY \
    -l $GROUP_PLAYBOOK \
    "$here/$GROUP_PLAYBOOK.yml" \
    --ask-pass --ask-become-pass --extra-vars=$EXTRA_VARS
