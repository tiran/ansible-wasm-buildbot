#!/bin/sh
set -e
ansible-galaxy install -r requirements.yml
exec ansible-playbook playbook.yml "$@"

