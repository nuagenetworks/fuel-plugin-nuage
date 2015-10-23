# Copyright 2015 Alcatel-Lucent USA Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
import argparse
import logging
import os
import sys
from uuid import getnode

def dummy(msg):
    return msg

import __builtin__
__builtin__.__dict__['_'] = dummy

def get_mac():
    mac = getnode()
    return ':'.join(("%012X" % mac)[i:i + 2] for i in range(0, 12, 2))

DEFAULT_CMS_NAME = 'OpenStack_' + get_mac()

from restproxy import RESTProxyServer

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())

REST_SUCCESS_CODES = range(200, 207)

def init_arg_parser():

    parser = argparse.ArgumentParser()
    parser.add_argument('--server', action='store', required=True,
                        help='VSD IP address')
    parser.add_argument('--serverauth', action='store', required=True,
                        help='VSD login username and password')
    parser.add_argument('--organization', action='store', required=True,
                        help='VSD organization')
    parser.add_argument('--auth_resource', action='store', required=True,
                        help='VSD auth resource')
    parser.add_argument('--serverssl', action='store', required=True,
                        help='VSD Server SSL')
    parser.add_argument('--base_uri', action='store', required=True,
                        help='Nuage Base URI')    
    parser.add_argument('--name', action='store',
                        default=DEFAULT_CMS_NAME,
                        help='The name of the CMS to create on VSD')
    return parser


def main():
    parser = init_arg_parser()
    args = parser.parse_args()

    try:
        restproxy = RESTProxyServer(server=args.server,
                                    base_uri=args.base_uri,
                                    serverssl=args.serverssl,
                                    serverauth=args.serverauth,
                                    auth_resource=args.auth_resource,
                                    organization=args.organization)
    except Exception as e:
        logger.error('Error in connecting to VSD:%s' % str(e))
        sys.exit(1)

    response = restproxy.rest_call('POST', "/cms", {'name': args.name})
    if response[0] not in REST_SUCCESS_CODES:
        logger.error('Failed to create CMS on VSD.')
        sys.exit(1)

    cms_id = response[3][0]['ID']
    cfgfile = open("cms_id.txt",'w')
    cfgfile.write(cms_id)
    cfgfile.close()

if __name__ == '__main__':
    main()
