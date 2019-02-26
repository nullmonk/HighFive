#!/bin/bash

# Install the linux integration services for Hyper-V

echo -e "hv_vmbus\nhv_storvsc\nhv_blkvsc\nhv_netvsc\n" >> /etc/initramfs-tools/modules
apt-get install -y hyperv-daemons
update-initramfs -u