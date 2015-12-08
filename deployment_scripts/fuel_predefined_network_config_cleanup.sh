set -x

ROUTER=router04

EXTERNAL_NW=net04_ext
EXTERNAL_SUBNET=net04_ext__subnet

TENANT_NW=net04
TENANT_SUBNET=net04__subnet

source ~/openrc

EXT_NET_ID=$(neutron net-list | grep $EXTERNAL_NW | awk '{print $2;}')
neutron router-gateway-clear $ROUTER $EXT_NET_ID

neutron subnet-delete $EXTERNAL_SUBNET
neutron net-delete $EXTERNAL_NW

TENANT_SUBNET_ID=$(neutron subnet-list | grep $TENANT_SUBNET | awk '{print $2}')
neutron router-interface-delete $ROUTER $TENANT_SUBNET_ID

neutron subnet-delete $TENANT_SUBNET
neutron net-delete $TENANT_NW

neutron router-delete $ROUTER

if [[ $(neutron port-list) ]]; then
    echo "Fuel pre-defined vports exist on Controller nodes"
    cleanup=False
else
    echo "Fuel pre-defined vports successfully cleaned up on Controller nodes"
fi

if [[ $(neutron subnet-list) ]]; then
    echo "Fuel pre-defined subnets exist on Controller nodes"
    cleanup=False
else
    echo "Fuel pre-defined subnets successfully cleaned up on Controller nodes"
fi

if [[ $(neutron net-list) ]]; then
    echo "Fuel pre-defined networks exist on Controller nodes"
    cleanup=False
else
    echo "Fuel pre-defined networks successfully cleaned up on Controller nodes"
fi

if [[ $(neutron router-list) ]]; then
    echo "Fuel pre-defined routers exist on Controller nodes"
    cleanup=False
else
    echo "Fuel pre-defined routers successfully cleaned up on Controller nodes"
fi

if [[ "$cleanup" == "False" ]]; then
    echo "Cleanup of pre-defined Fuel network configuration on Controller nodes failed"
    exit 1
else
    echo "Cleanup of pre-defined Fuel network configuration on Controller nodes succeeded"
fi
