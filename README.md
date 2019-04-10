mailweb: Matt's Mail and Web Ansible Config
===========================================

## What Is It?

This is an Ansible playbook containing Ansible roles to configure
my personal mail infrastructure components including:

- postfix
- dovecot
- rspamd
- borg-backup
- fail2ban
- sqlite

Also includes web components for installing multi-site `nginx` servers.

`mailweb` was created to apply on modern Ubuntu servers with a current
release version of Bionic 18.04 LTS (meaning: packages are deployed using
the `apt` module only currently).

A full writeup about this architecutre is at [Building a Production Mail Server in 2018](https://matt.sh/email2018)

## Organization

To avoid mistakes like accidentally publishing all your private keys or
backup passphrases, we take advantage of Ansible's directory search hierarchy
to isolate non-public content from role directories.

For example: to avoid committing our private keys to the public repository,
instead of putting keys in a subdirectory of the role itself (e.g. `./roles/certs/files/tls/site-key.pem`),
we place them at the top level `files` path Ansible also searches (e.g. `./files/certs/tls/site-key.pem`).

The same goes for `hosts_vars` and `group_vars` using this insight from the
[Ansible docs](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#splitting-out-host-and-group-specific-data):

> Tip: The `group_vars/` and `host_vars/` directories can exist in the playbook directory OR the inventory directory. If both paths exist, variables in the playbook directory will override variables set in the inventory directory.

So, we place our sample vars in `inventory/{group,host}_vars` for publishing in this
repository, then for actual usage we write production vars at the top level (which overrides the `inventory/*` vars).

Now all we have to do is _not_ commit top level `files`, `group_vars`, and `host_vars` directories
into the public repository (only commit on local internal branches). This is helped
by our `.gitignore` in the public branch. View comments in `.gitignore` for more details
about private usage.

## SQLite

Each user must have a password. It is always a good practice to hash passwords stored in a database, in case the database is compromised. If a user's password is MY_PASSWORD, you can hash it using Dovecot's password hash generator:

```console
$ doveadm pw -s SSHA512
Enter new password:MY_PASSWORD
Retype new password:MY_PASSWORD
{SSHA512}HASHED_PASSWORD
```
Next edit sqlite.yml, and replace HASHED_PASSWORD with the exact output of the command.

## Contributing

Contributions welcome! Any PRs about improving configs towards security, usability, performance, and cross platform growth is encouraged.

If you want to make changes for your own needs (but maybe not for _everybody's_ needs), feel free to submit the changes and just guard them with enable `when` blocks activated by config variables.

Hopefully we can keep this architecture alive as its package components and underlying distributions grow over time.

### Potential Problems

- Not extensively tested outside my personal environment
    - there's probably default vars missing in places; feel free to submit fixes

### Acceptable Improvements

- Feel free to submit better cross-platform integration
    - cross-OS package management (`if centos` vs. `if debian` etc)
        - should include better version checking/version pinning so we don't try to load 2018 configs into older servers not supporting modern options
    - cross-OS config file locations, handlers, etc
- Update config files when [newer standards or features](https://matt.sh/web2018) get implemented and released
