MASTER_SERVER=$1

sudo service keepalived stop
sudo pg_ctlcluster 9.5 main stop -m fast

sudo -u postgres rm -rf /var/lib/postgresql/9.5/main/ && \
sudo -u postgres repmgr -h $MASTER_SERVER -U repmgr -d repmgr -D /var/lib/postgresql/9.5/main/ -f /etc/postgresql/9.5/main/repmgr.conf standby clone && \
sudo pg_ctlcluster 9.5 main start && \
sudo -u postgres repmgr -F -f /etc/postgresql/9.5/main/repmgr.conf standby register && \
sudo service repmgrd start
