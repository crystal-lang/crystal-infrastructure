## Simple Ansible playbooks to setup arm.build.crystal-lang.org

### How to use

1. Setup a basic Ubuntu 18.04 install on the host:
  * Default user username: `crystal`
  * Set output of `pwgen 20 1` as password, share with other admins.
  * Ensure OpenSSH server is installed as additional software.
  * Enable SSH access for your private key to that user: `ssh-copy-id crystal@arm.build.crystal-lang.org`.
1. Run `crystal collect_keys.cr`.
1. Run `ansible-playbook setup-host.yml --ask-become-pass`.
1. Run `ansible-playbook create-vms.yml --ask-become-pass`.
  * This recreates the VMs if they already exist.
1. Obtain a Github personal access token that can create self hosted runners on crystal-lang/crystal.
1. Once the VMs booted, run `ansible-playbook setup-vms.yml --ask-become-pass`.
  * You can watch them boot with `virsh console  <vmname>`, use `Ctrl+]` to exit.
  * The initial VM password after the previous step is `changeme`.
  * When prompted for the new password, use same password as for the host above.

### ACL

To add or remove access to a person

1. Edit `collect_keys.cr`.
1. Run `crystal collect_keys.cr`.
1. Run `ansible-playbook update-authorized_keys.yml --ask-become-pass`.
1. Commit and push any changed files.

* TODO provide playbook to rotate the password.

### Scaling

1. Edit `hosts` to add or remove VMs.
1. Run `ansible-playbook create-vms.yml --ask-become-pass`.
1. Obtain a Github personal access token that can create self hosted runners on crystal-lang/crystal.
1. Once the VMs booted, run `ansible-playbook setup-vms.yml --ask-become-pass`, see above.