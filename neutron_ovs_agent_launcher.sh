#!/bin/bash
set -xe

/usr/bin/neutron-openvswitch-agent --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini --config-file /etc/neutron/plugins/ml2/openvswitch_agent.ini --log-file=/var/log/neutron/neutron.log
