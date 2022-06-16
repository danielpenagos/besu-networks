# Deploying a Node

* Below you will find instructions for the deployment of writer nodes  using docker-compose on ProTest and David19 networks. This implies that it will run on your local machine and you must have docker and docker compose installed.



* In order for your node to get permissioned, you need to complete the permissioning process first. In order to understand better what are the types of networks available and the permissioning processes for each network, please check the [README](https://github.com/LACNetNetworks/besu-networks/blob/master/README.md).



## Minimum System Requirements

Recommended hardware features for Besu node:

| Recommended Hardware | On Testnet-David19 | On Pro-Testnet |
|:---:|:---:|:---:|
| CPU | 2 vCPUs | 2 vCPUs | 
| RAM Memory | 8 GB | 8 GB | 
| Hard Disk | 100 GB SSD | 200 GB SSD |


* **Docker Host**:

It is necessary to enable the following network ports in the machine in which we are going to deploy the node:

* **Besu Node**:
  * **60606**: TCP/UDP - Port to establish communication p2p between nodes.

  * **4545**: TCP - Port to establish RPC communication. (this port is used for applications that communicate with LACChain and may be leaked to the Internet)
* **Nginx**:
  * **8080**: TCP - Port to establish RPC communication to Gas Model.

## Pre-requisites

### Install Docker Desktop ###

For this installation we will use docker-compose. It is necessary to install **docker** and **docker-compose** on a local machine that will perform the installation of the node .

Following the instructions to [install docker desktop](https://docs.docker.com/desktop/#download-and-install) in your local machine.



### Clone Repository ####

To configure and install Besu and Tessera, you must clone this git repository in your **local machine**.

```shell
$ git clone https://github.com/LACNetNetworks/besu-networks
$ cd besu-networks/docker/compose
```



## Node Installation ##

### Preparing installation of a new node ###

* There are three types of nodes (Bootnode / Validator / Writer)  that can be created in the blockchain networks orchestrated by LACNet but this moment **only deploy writer node** using  **docker-compose**.

### environment variable ###
* **Besu Node**:

  * **BESU_LOGGING**:LOGGING  - Level logging Besu (INFO, DEBUG, TRACE) - default INFO.

  * **BESU_P2P_HOST**: P2P Public IP Egress.  

  * **BESU_P2P_PORT**: P2P PORT  - Default (60606).

  * **PUBLIC_IP**:  TCP Public IP.

  * **NODE_NAME**: Name you want for your node in the network monitoring tool.

  * **NODE_EMAIL**: email address you want to register for your node in the network monitoring tool. It's a good idea to provide the e-mail of the technical contact identified or to be identified in the registration form as part of the on-boarding process.


### Deploying the new node ###

* Depending on the network you want to deploy the node, you need to move into the following folder structure:


```
docker
  ├──compose  
    ├── david19
    └── protest

```
So, if you want to deploy a writer node on   pro-testnet cd to protest or testet-david19 cd to  david19.



 * To deploy a **Node Writer**     
      
      ```
      $ docker-compose -f docker-compose-writer.yml up -d
      ```


* At the end of the installation, if everything worked a BESU service will be created managed by Systemctl with **Running** status.


Don't forget to write down your node's "enode" :
```shell
  $ curl -X POST --data '{"jsonrpc":"2.0","method":"net_enode","params":[],"id":1}' http://localhost:4545

```
Result:
```
"result" : "enode://d837cb6dd3880dec8360edfecf49ea7008e50cf3d889d4f75c0eb7d1033ae1b2fb783ad2021458a369db5d68cf8f25f3fb0080e11db238f4964e273bbc77d1ee@104.197.188.33:60606"

```



* In order to be permissioned, now you need to follow [administrative steps of the permissioning process](https://github.com/LACNetNetworks/besu-networks/blob/master/README.md).
* Once you are permissioned, you can verify that you are connected to other nodes in the network by following the steps detailed in [#issue33](https://github.com/lacchain/besu-network/issues/33).

## Node Configuration

### Configuring the Besu node file ###

The default configuration should work for everyone. However, depending on your needs and technical knowledge you can modify your  node's settings in  `config-writer.toml`, for RPC access or authentication. Please refer to the [reference documentation](https://besu.hyperledger.org/en/21.1.6/Reference/CLI/CLI-Syntax/).

	
## Checking your connection

Once you have been permissioned, you can check if your node is connected to the network properly.

Check that the node has stablished the connections with the peers:

```shell

$ curl -X POST --data '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":1}' http://localhost:4545
```

You should get a result like this:

![Connections](/docs/images/log_connections.PNG)

Now you can check if the node is syncing blocks by getting the log:

```shell
$ docker logs <container name> -f 
$ docker logs writer-besu-david19  -f
```

You should get something like this:

![Log of latest blocks](/docs/images/log_blocks.PNG)

If any of these two checks doesn't work, try to restart the besu service: e.g. **Node Writer**

```shell
$ docker-compose -f docker-compose-writer.yml stop
$ docker-compose -f docker-compose-writer.yml up -d
```

If that doesn't solve the problem, [open a ticket](https://lacnet.lacchain.net/support/) if you already have a membership or contact us at tech.support@lac-net.net.
	
## Deploying Dapps

For a quick overview of some mainstream tools that you can use to deploy Smart Contracts, connect external applications and broadcast transactions to the LACChain Besu Network, you can check our [guide](https://github.com/LACNet-Networks/besu-pro-testnet/blob/master/docs/DEPLOY_APPLICATIONS.md). We also recommend you [our tutorials to deploy your first smart contracts](https://github.com/LACNet-Networks/gas-management/tree/master/docs/tutorial).

## Contact

For any issues, you can either go to [issues](https://github.com/LACNet-Networks/besu-pro-testnet/issues) or e-mail us at tech-support@lac-net.net. Any feedback is more than welcome!

## Copyright 2022 LACNet

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
