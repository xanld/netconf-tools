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

`docker run -d -p 2222:22 ghcr.io/xanld/netconf-tools:0.2`


## Docker Compose

```yaml
services:
  netconftools:
    image: 'ghcr.io/xanld/netconf-tools:0.2'
    ports:
      - '2222:22'
    restart: 'unless-stopped'
```

Run with

`docker compose up -d`

## K8s

Coming soon
