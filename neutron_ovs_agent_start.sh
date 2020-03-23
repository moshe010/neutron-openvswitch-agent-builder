#!/bin/bash
LOG_DIR_HOST=/var/log/neutron
CONF_DIR_HOST=/etc/neutron
BRANCH=stein
IMAGE_NAME=mellanox/centos-binary-neutron-openvswitch-agent-${BRANCH}-aarch64
CONTAINER_NAME=neutron_ovs_agent

# Create log folder and grant permissions
mkdir -p ${LOG_DIR_HOST}
chown 42435:42435 ${LOG_DIR_HOST}
chmod 755 ${LOG_DIR_HOST}

# Create container
docker container create \
--network host \
--user 42435:42435 \
--privileged \
--name ${CONTAINER_NAME} \
--restart unless-stopped \
-v /run/openvswitch:/run/openvswitch/ \
-v ${LOG_DIR_HOST}:/var/log/neutron \
-v ${CONF_DIR_HOST}:/etc/neutron \
-v ${PWD}:/usr/bin/scripts \
${IMAGE_NAME} \
bash /usr/bin/scripts/neutron_ovs_agent_launcher.sh

# Start container
docker start ${CONTAINER_NAME}
