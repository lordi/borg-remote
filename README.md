# Borg Backup Remote To Local
![alt text](https://borgbackup.readthedocs.io/en/stable/_static/logo.png "Borgbackup")

## Description

[BorgBackup](https://github.com/borgbackup) does not have support yet for
backing up a remote server to a local destination (or a destination that we can
only access from local). The workaround mentioned in the docs is via `sshfs`
which is very slow.

This repository contains a Docker image for a local borg server and a script
that will spin up a local borg server, connect via SSH to remote server and
backup your files via a SSH tunnel. This way, the file collector will be fast
as it runs on the remote server but the backup will still be stored locally.

Based on [grantbevis/borg-server](https://github.com/grantbevis/borg-server).

## Requirements

Local requirements:

 * Docker
 * Docker Compose

Remote requirements:

 * borg
 * generated ssh key (e.g. `~/.ssh/id_rsa`)

## Usage

 1. Copy `.env.default` to `.env` and fill out the details.
 2. Run `backup.sh`

## Disclaimer

Use at your own risk, this is highly experimental.
