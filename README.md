# netconf-tools

Alpine based container for network troubleshooting including following tools:

* netconf-console2
* snmp
* iperf
* wireshark
* nmap
* tcpdump
* traceroute

Accessible via ssh with user:pass `xuser:xuser`


## Docker

`docker run -d -p 2222:22 ghcr.io/xanld/netconf-tools:latst`


## Docker Compose

```yaml
services:
  netconf-tools:
    image: 'ghcr.io/xanld/netconf-tools:latest'
    ports:
      - '2222:22'
    restart: unless-stopped
    container_name: netconf-tools
```

Run with

`docker compose up -d`

## K8s

Coming soon
