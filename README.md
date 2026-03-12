# Docker DNS Round Robin & Service Discovery Lab

This project demonstrates the power of Docker's internal DNS engine and its native load-balancing capabilities within user-defined bridge networks.


## Architectural Overview

The setup consists of a scalable microservice layer and a specialized testing client, all isolated within a custom bridge network.


**API Nodes:** Three instances of the bretfisher/httpenv image. Each container responds with a JSON object containing its unique HOSTNAME to verify traffic distribution.


**Tester Node:** A rockylinux:10 container equipped with networking tools like curl and nslookup to simulate client-side requests.


**Internal Network:** A private bridge network (internal-net) that enables automatic service discovery.

# Getting Started
Deploy the entire infrastructure with a single command:

```bash
docker compose up -d
```

# Testing
The success of the Load Balancing mechanism is verified through two distinct phases:


**1. DNS Resolution Check**

By executing nslookup within the tester container, we confirm that a single hostname resolves to multiple internal IP addresses:

```bash
docker exec -it <tester-container-name> nslookup lb-search
```

The query returns three unique IPs (e.g., 172.21.0.3, 172.21.0.4, 172.21.0.5), proving the DNS multi-value response.


**2. Traffic Rotation (Round Robin)**

Successive curl requests demonstrate that Docker's DNS engine rotates the target container for every new connection:

```bash
curl -s lb-search:8888 | grep HOSTNAME
```
Repeat this command 3-4 times

Each response returns a different HOSTNAME (Container ID), confirming that traffic is being balanced across all available nodes.
