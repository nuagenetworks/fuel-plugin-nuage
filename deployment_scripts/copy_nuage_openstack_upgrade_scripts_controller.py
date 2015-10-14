import argparse
import paramiko
import socket
import logging
import os

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())

global host, username, password, copy_file, plugin_version

parser = argparse.ArgumentParser(description="Copy the openstack upgrade package from Fuel")
parser.add_argument('-i', '--host', help="IP address of the Fuel node",
                    action='store')
parser.add_argument('-u', '--username', help="User name for Fuel node login",
                    action='store')
parser.add_argument('-p', '--password', help="Password for Fuel node login",
                    action='store')
parser.add_argument('-f', '--copy_file', help="Nuage Openstack Upgrade scripts file",
                    action='store')
parser.add_argument('-v', '--plugin_version', help="Fuel Nuage Plugin Version",
                    action='store')

args = parser.parse_args()
host = args.host
username = args.username
password = args.password
copy_file = args.copy_file
plugin_version = args.plugin_version

remote_path = "/var/www/nailgun/plugins/nuage-" + plugin_version + "/repositories/ubuntu/" + copy_file
local_path = "/root/nuage-openstack-upgrade.tar.gz"
ssh = paramiko.SSHClient()
try:
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname=host, username=username, password=password, timeout=60.0)
    sftp = ssh.open_sftp()
    sftp.get(remote_path,local_path)
    sftp.close()
    ssh.close()
except paramiko.AuthenticationException:
    logger.error("Bad credentials for host")
except paramiko.SSHException:
    logger.error("Issues with SSH service")
except socket.error:
    logger.error("Host unreachable")

dir = '/root/nuage-cms'

if os.path.exists(dir):    
    ret = os.system("rm -irf %s" % dir)

ret = os.chdir('/root')
ret = os.system("mkdir -p nuage-cms")
ret = os.system("tar -xzvf nuage-openstack-upgrade.tar.gz -C nuage-cms")
