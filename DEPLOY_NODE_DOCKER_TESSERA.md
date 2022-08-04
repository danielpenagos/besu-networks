# Create Private Channel


* Here you will find instructions to create private channel using Tessera on **Dockers** .



## Minimum System Requirements

Recommended hardware features for Tessera node:

| Recommended Hardware  | On Pro-Testnet |
|:---:|:---:|
| CPU | 2 vCPUs | 
| RAM Memory | 8 GB | 
| Hard Disk  | 200 GB SSD |


* **Docker Host**:

It is necessary to enable the following network ports in the machine in which we are going to deploy the node:

* **Tessera Node - component for private transactions**: 
  * **4040**: TCP - Port to communicate with other Tessera nodes.
  
  * **4444**: TCP - Port for communication between Besu and Tessera.

## Pre-requisites

### Install Docker Desktop ###

For this installation we will use docker-compose. It is necessary to install **docker** and **docker-compose** on a local machine that will perform the installation of the node .

Following the instructions to [install docker desktop](https://docs.docker.com/desktop/#download-and-install) in your local machine.



### Clone Repository ####

To configure and install Besu  and Tessera, you must clone this git repository in your **local machine**.

```shell
$ git clone https://github.com/LACNetNetworks/besu-networks
$ cd besu-networks/docker/compose
```



## Node Installation ##

### Preparing installation of a new Tessera node ###

* That can be created in the private network in blockchain networks orchestrated by LACNet  using  **docker-compose**.

### environment variable ###
* **Tessera Node**:

  * **BESU_LOGGING**:LOGGING  - Level logging Besu (INFO, DEBUG, TRACE) - default INFO.

  * **BESU_P2P_HOST**: P2P Public IP (IP public your local machine ).  

  * **BESU_P2P_PORT**: P2P PORT  - Default (60606).

  * **PUBLIC_IP**:  TCP Public IP (IP public your local machine ).

  * **NODE_NAME**: Name you want for your node in the network monitoring tool.

  * **NODE_EMAIL**: email address you want to register for your node in the network monitoring tool. It's a good idea to provide the e-mail of the technical contact identified or to be identified in the registration form as part of the on-boarding process.
 
  * **HOST_TESSERA_PEER** :Host another tessera node of the private network

  * **BESU_PRIVACY_URL** : name tessera container used by besu node.

### Deploying the new Tessera node ###

* Depending on the network you want to deploy the node, you need to move into the following folder structure:


```
docker
  ├──compose  
    └── protest

```
So, if you want to deploy a tessera node on **Pro-Testnet** then **cd** to **protest**.



 * To deploy a **Node Tessera**     
      
      ```
      $ docker-compose -f docker-compose-tessera.yml up -d
      ```


* At the end of the installation, if everything worked a BESU and Tessera   container will be created managed by docker with **Up** status.


	
## Checking your node Tessera



Check status the node tessera:

```shell

$ curl -X GET  http://localhost:4444/upcheck
```

You should get a result like this:

```
I'm up!
```

Now you can check  log node tessera:

```shell
$ docker logs <container name> -f 
$ docker logs writer-tessera-david19  -f
```



If any of these two checks doesn't work, try to restart the tessera service: 

```shell
$ docker-compose -f docker-compose-tessera.yml stop
$ docker-compose -f docker-compose-tessera.yml up -d
```

If that doesn't solve the problem, [open a ticket](https://lacnet.lacchain.net/support/) if you already have a membership or contact us at tech.support@lac-net.net.
	


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
