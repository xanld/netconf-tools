# netconf-tools

Alpine based container for network troubleshooting including following tools:

* netconf-console2
* snmp
* iperf
* tshark
* nmap
* tcpdump
* traceroute
* openssl

Accessible via ssh with user:pass `xuser:xuser`

Note: to use the `tshark` utility, you need to add `NET_ADMIN` and `NET_RAW` as capabilities. These are disabled by default.

## Docker

`docker run -d -p 2222:22 ghcr.io/xanld/netconf-tools:latest`


## Docker Compose

```yaml
services:
  netconf-tools:
    image: 'ghcr.io/xanld/netconf-tools:latest'
    ports:
      - '2222:22'
    restart: unless-stopped
    container_name: netconf-tools
    #cap_add: #if wanting to use tshark, uncomment
    #  - NET_ADMIN
    #  - NET_RAW
```

Run with

`docker compose up -d`

## K8s

Use the provided file `k8s-netconf-tools.yaml` and apply it to your cluster:

`kubectl apply -f k8s-netconf-tools.yaml`

By default it will create a NodePort `32222`. For using with a load balancer, edit the provided file accordingly.


## K8s Debug (ephemeral) container

You can run the container directly (this will not create a service/NodePort) and attach to it.

Use the following command to attach to a running pod as an ephemeral container:

`kubectl debug -it --image=ghcr.io/xanld/netconf-tools:latest <POD_NAME> -n <POD_NAMESPACE> -- /bin/sh`

To remove the debug container you can simply kill/restart the pod you attached to.
