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
from configobj import ConfigObj

def dummy(msg):
    return msg

import __builtin__
__builtin__.__dict__['_'] = dummy

from nuagenetlib.restproxy import RESTProxyServer

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())

REST_SUCCESS_CODES = range(200, 207)

class NuagePluginConfig(object):
    def __init__(self, cfg_file_location):
        self.config = ConfigObj(cfg_file_location)
        self.config.filename = cfg_file_location

    def get(self, section, key):
        try:
            return self.config[section].get(key)
        except KeyError:
            return self.config[section.upper()].get(key)

    def set(self, section, key, value):
        try:
            self.config[section][key] = value
        except KeyError:
            self.config[section.upper()][key] = value

    def write_file(self):
        self.config.write()

def init_arg_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('--config-file', action='store', required=True,
                        help='The location of the nuage_plugin.ini file')
    parser.add_argument('--name', action='store',
                        help='The name of the CMS to create on VSD')
    return parser


def main():
    parser = init_arg_parser()
    args = parser.parse_args()

    if not os.path.isfile(args.config_file):
        logger.error('File "%s" cannot be found.' % args.config_file)
        sys.exit(1)

    plugin_config = NuagePluginConfig(args.config_file)

    server = plugin_config.get('RESTPROXY', 'server')
    base_uri = plugin_config.get('RESTPROXY', 'base_uri')
    serverssl = plugin_config.get('RESTPROXY', 'serverssl')
    serverauth = plugin_config.get('RESTPROXY', 'serverauth')
    auth_resource = plugin_config.get('RESTPROXY', 'auth_resource')
    organization = plugin_config.get('RESTPROXY', 'organization')

    try:
        restproxy = RESTProxyServer(server=server,
                                    base_uri=base_uri,
                                    serverssl=serverssl,
                                    serverauth=serverauth,
                                    auth_resource=auth_resource,
                                    organization=organization)
    except Exception as e:
        logger.error('Error in connecting to VSD:%s' % str(e))
        sys.exit(1)

    cms_id = plugin_config.get('RESTPROXY', 'cms_id')
    if cms_id:
        logger.info("CMS ID already exists in the plugin file; no need for adding CMS id to the file")
        return

    headers = {}
    headers['X-Nuage-Filter'] = "name IS '%s'" % args.name
    response = restproxy.rest_call('GET', "/cms",'', headers)

    if response[0] not in REST_SUCCESS_CODES:
        logger.error('Failed to create CMS on VSD.')
        sys.exit(1)

    id = response[3][0]['ID']
    plugin_config.set('RESTPROXY', 'cms_id', id)
    plugin_config.write_file()
    logger.info("Successfully added CMS id to the plugin file on the standby controller")

if __name__ == '__main__':
    main()
