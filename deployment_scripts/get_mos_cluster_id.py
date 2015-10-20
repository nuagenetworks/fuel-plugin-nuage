import argparse
import paramiko
import socket
import logging
import os

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())

global host, username, password, copy_file

parser = argparse.ArgumentParser(description="Copy the openstack upgrade package from Fuel")
parser.add_argument('-i', '--host', help="IP address of the Fuel node",
                    action='store')
parser.add_argument('-u', '--username', help="User name for Fuel node login",
                    action='store')
parser.add_argument('-p', '--password', help="Password for Fuel node login",
                    action='store')

args = parser.parse_args()
host = args.host
username = args.username
password = args.password

def get_mos_cluster_id():
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        ssh.connect(hostname=host, username=username, password=password, timeout=60.0)
        stdin, stdout, stderr = ssh.exec_command("fuel env | grep operational | awk '{print $1}'")
        cluster_id = stdout.read()
        if cluster_id is "":
            logger.error("Failed to obtain Mirantis Openstack Environment ID")
        else:
            logger.info("Successfully obtained Mirantis Openstack Environment ID")

        ssh.close()
        file = open("/root/cluster_id.txt", "w")
        file.write(cluster_id)
        file.close()

    except paramiko.AuthenticationException:
        logger.error("Bad credentials for host")
    except paramiko.SSHException:
        logger.error("Issues with SSH service")
    except socket.error:
        logger.error("Host unreachable")

def main():

    get_mos_cluster_id()

if __name__ == "__main__":
    main()
