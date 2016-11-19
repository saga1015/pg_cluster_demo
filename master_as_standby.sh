# rewind db changes 
NEW_MASTER=$1

sudo -u postgres /usr/lib/postgresql/9.5/bin/pg_rewind -D /var/lib/postgresql/9.5/main/ --source-server="host=$NEW_MASTER dbname=repmgr user=repmgr"
# follow master (creates recovery.conf)
sudo -u postgres repmgr -f /etc/postgresql/9.5/main/repmgr.conf -h $NEW_MASTER -U repmgr -d repmgr -D /var/lib/postgresql/9.5/main/ standby follow