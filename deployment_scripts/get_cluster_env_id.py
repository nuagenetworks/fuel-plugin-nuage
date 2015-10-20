import argparse
import paramiko
import socket
import logging
import time
import itertools

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())

global host, username, password

parser = argparse.ArgumentParser(description="Copy the openstack upgrade package from Fuel")
parser.add_argument('-i', '--host', help="IP address of the Fuel node",
                    action='store')
parser.add_argument('-u', '--username', help="User name for Fuel node login",
                    action='store')
parser.add_argument('-p', '--password', help="Password for Fuel node login",
                    action='store')
parser.add_argument('-v', '--vip', help="Management VIP for the cluster",
                    action='store')

args = parser.parse_args()
host = args.host
username = args.username
password = args.password
vip = args.vip

def get_mos_cluster_id():
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    file_list = list()
    try:
        ssh.connect(hostname=host, username=username, password=password, timeout=60.0)
        stdin, stdout, stderr = ssh.exec_command("fuel env | grep operational | awk '{print $1}'")
        out = stdout.read()
        if out is "":
            logger.error("Failed to extract MOS Environment IDs")
        else:
            logger.info("Successfully extracted MOS Environment IDs")

        file = open("/root/cluster_ids.txt", "w")
        file.write(out)
        file.close()

        f = open("/root/cluster_ids.txt")
        filecontents = f.readlines()
        env_id_list = list()
        for line in filecontents:
            id = line.strip('\n')
            env_id_list.append(id)

        for id in env_id_list:
            stdin, stdout, stderr = ssh.exec_command("fuel network --env %s --download" % id)
            time.sleep(10)
            file = "network_" + id + ".yaml"
            file_list.append(file)

        for file,id in itertools.izip(file_list,env_id_list):
            stdin, stdout, stderr = ssh.exec_command("cat %s | grep management_vip | awk '{print $2}'" % file)
            mgmt_vip = stdout.read()
            if vip in mgmt_vip:
                file = open("/root/mos_unique_id.txt", "w")
                file.write(id)
                file.close()
                break

        ssh.close()
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
