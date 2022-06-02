# Deploying a Node

* Below you will find instructions for the deployment of nodes using Kubernetes. This implies that it will be executed from a local machine on a remote server. The local machine and the remote server will communicate via kubectl.

* The installation with kubernetes manifests  is compatible with **Google Kubernetes Engine** .

* In order for your node to get permissioned, you need to complete the permissioning process first. In order to understand better what are the types of networks available and the permissioning processes for each network, please check the [README](https://github.com/LACNetNetworks/besu-networks/blob/master/README.md).

* If an organization intends to create private channels, we have facilitated the integration with the private transaction manager [Tessera](https://docs.tessera.consensys.net/en/stable/). It is worth mentioning that **Tessera is optional** and entities can join the networks only with Besu nodes.

## Minimum System Requirements

Recommended hardware features for Besu node:

| Recommended Hardware | On Testnet-David19 | On Pro-Testnet | On Mainnet-Omega |
|:---:|:---:|:---:|:---:|
| CPU | 2 vCPUs | 2 vCPUs | 4 vCPUs compute optimized|
| RAM Memory | 8 GB | 8 GB | 16 GB |
| Hard Disk | 100 GB SSD | 200 GB SSD | 300 GB SSD |
| IOPs | ----- | ----- | 70,000 IOPS READ  50,000 IOPS WRITE |

* **Kubernetes**: Google Kubernestes Engine GKE.

It is necessary to enable the following network ports in the machine in which we are going to deploy the node:

* **Besu Node**:
  * **60606**: TCP/UDP - Port to establish communication p2p between nodes.

  * **4545**: TCP - Port to establish RPC communication. (this port is used for applications that communicate with LACChain and may be leaked to the Internet)

* **Tessera Node (Optional component for private transactions)**: 
  * **4040**: TCP - Port to communicate with other Tessera nodes.
  
  * **4444**: TCP - Port for communication between Besu and Tessera.

## Pre-requisites

### Install Kubectl ###

For this installation we will use Kubectl. It is necessary to install Kubectl on a **local machine** that will perform the installation of the node on a **kubernetes cluster**.

Following the instructions to [install kubectl](https://kubernetes.io/docs/tasks/tools/) in your local machine.



### Clone Repository ####

To configure and install Besu and Tessera, you must clone this git repository in your **local machine**.

```shell
$ git clone https://github.com/LACNetNetworks/besu-networks
$ cd besu-networks/k8s/
```



## Node Installation ##

### Preparing installation of a new node ###

* There are three types of nodes (Bootnode / Validator / Writer) + the optional Tessera (for private side-chains) that can be created in the blockchain networks orchestrated by LACNet at this moment.

### environment variable ###
* **Besu Node**:

  * **BESU_LOGGING**:LOGGING  - Level logging Besu (INFO, DEBUG, TRACE) - default INFO.

  * **P2P_HOST**: P2P Public IP Egress.  

  * **P2P_PORT**: P2P PORT  - Default (60606).

  * **NODE_NAME**: Name of the node worker where always the pod will be installed.

  * **PUBLIC_IP**: TCP Public IP Ingress.

* **Nginx Server**:
  * **PUBLIC_IP**:  TCP Public IP Ingress.

  * **HOST_RELAY_SIGNER**: IP relay signer service - dafault (127.0.0.1).

  * **HOST_BESU**: IP  Node Besu . default (127.0.0.1).

* **Relay signer**:
  * **HOST_BESU**: IP  Node Besu . default (127.0.0.1).
  
  * **CONTRACT_ADDRESS**: Contract address relay signer.

* **Eth Stats**:
  * **HOST_BESU**: Name pod  Node Besu . default (writer-besu-lacchain).
  
  * **NODE_NAME**: Name you want for your node in the network monitoring tool.

  * **NODE_EMAIL**: email address you want to register for your node in the network monitoring tool. It's a good idea to provide the e-mail of the technical contact identified or to be identified in the registration form as part of the on-boarding process.

* **Tessera Node**:

  * **PUBLIC_IP**: TCP Public IP Ingress.

  * **HOST_TESSERA**: TCP  IP Besu Node.

  * **HOST_TESSERA_PEER**: TCP IP  - another tessera peer.

  * **DNS_NAME**: Organization domain name (e.g. lacchain.com). 

### Set value to environment variable ###
* **TCP Public IP Ingress**: Generate a *_static public IP_* in your cloud provider. Then replace the public ip in the load balance *_(loadBalancerIP)_* service manifest. finally update the **PUBLIC_IP** environment variable with this IP.

* **P2P Public IP Egress**: Outgoing p2p traffic to synchronize besu nodes. This is the permissioned IP for the  network. Therefore, the pod must always be installed on the same worker node so that the IP does not change.
We obtain the name and IP of the cluster nodes with the following command.
    
    $ kubectl get nodes -o wide

![workers](/docs/images/workes-k8s.PNG)

 We choose a worker and update the **"nodeName"** value in the manifest of the pod we are going to deploy. finally update the **P2P_HOST** environment variable with worker IP external .
 
 *_Note: We validate that the pod has been deployed in the selected worker with the following command._*
    
    $ kubectl get pod -o wide 



### Deploying the new node ###

* Depending on the network you want to deploy the node, you need to move into the following folder structure:


```
├── david19
├── mainnet
└── protest

```
So, if you want to deploy a writer node on mainnet-omega, cd mainnet or  pro-testnet cd to protest or testet-david19 cd to  david19.

We deploy a node on Google Kubernetes engine :
    
      $ cd  google

 * To deploy a **Node Writer**     
      
      ```
      $ ./deploy-writer.sh 
      ```
 * To deploy a **Node Bootnode**     
      
      ```
      $ ./deploy-bootnode.sh 
      ```
 * To deploy a **Node Validator**     
      ```
      $ ./deploy-validator.sh 
      ```

 * To deploy a **Node Tessera**     
      ```
      $ ./remove-tessera.sh
      ```


* At the end of the installation, if everything worked a BESU service will be created managed by Systemctl with **Running** status.

K8s objects created are namespace, stateful pods, service load balancer, configmap, and volume.

Don't forget to write down your node's "enode" :
```shell
  $ curl -X POST --data '{"jsonrpc":"2.0","method":"net_enode","params":[],"id":1}' http://<PUBLIC_IP>:4545

```
Result:
```
"result" : "enode://d837cb6dd3880dec8360edfecf49ea7008e50cf3d889d4f75c0eb7d1033ae1b2fb783ad2021458a369db5d68cf8f25f3fb0080e11db238f4964e273bbc77d1ee@104.197.188.33:60606"

```

* If everything worked, an TESSERA service **(if it was chosen)** and a BESU service  **Running** status on Pod.


* In order to be permissioned, now you need to follow [administrative steps of the permissioning process](https://github.com/LACNetNetworks/besu-networks/blob/master/README.md).
* Once you are permissioned, you can verify that you are connected to other nodes in the network by following the steps detailed in [#issue33](https://github.com/lacchain/besu-network/issues/33).

## Node Configuration

### Configuring the Besu node file ###

The default configuration should work for everyone. However, depending on your needs and technical knowledge you can modify your  node's settings in  `besu-config-toml-configmap-xxx.yaml`, e.g.  besu-config-toml-configmap-writer.yaml for RPC access or authentication. Please refer to the [reference documentation](https://besu.hyperledger.org/en/21.1.6/Reference/CLI/CLI-Syntax/).

	
## Checking your connection

Once you have been permissioned, you can check if your node is connected to the network properly.

Check that the node has stablished the connections with the peers:

```shell

$ curl -X POST --data '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":1}' http://<PUBLIC_IP>:4545
```

You should get a result like this:

![Connections](/docs/images/log_connections.PNG)
x
Now you can check if the node is syncing blocks by getting the log:

```shell
$ kubectl logs <pod name> -c <container name> -f -n <namespace>
$ kubectl logs lacchain-writernode-0 -c lacchain-writernode -n lacchain-main-net
```

You should get something like this:

![Log of latest blocks](/docs/images/log_blocks.PNG)

If any of these two checks doesn't work, try to restart the besu service: e.g. **Node Writer**

```shell
$ remove-writer.sh
$ deploy-writer.sh
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
