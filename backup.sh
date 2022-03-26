source .env

# Spin up temporary borg server
docker-compose up -d
sleep 2

# Make backup from remote server to temporary borg server
ssh -R localhost:${FORWARD_PORT}:localhost:${FORWARD_PORT} ${SRC_HOST} <<EOF
  export BORG_PASSPHRASE="${BORG_PASSPHRASE}"
  export BORG_RSH="ssh -o StrictHostKeyChecking=no"
  export BORG_REPO=ssh://borg@localhost:${FORWARD_PORT}/backup
  export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes

  borg init -v --encryption=repokey ::
  borg create -s --list ::{now:%Y-%m-%d} ${SRC_DIRS}
EOF

# Shut down temporary borg server
docker-compose down
