# Create Private Channel

* Here you will find instructions to create private channel using Tessera on **Kubernetes** .



## Minimum System Requirements

Recommended hardware features for Tessera node:

| Recommended Hardware  | On Pro-Testnet | On Mainnet-Omega |
|:---:|:---:|:---:|
| CPU  | 2 vCPUs | 4 vCPUs compute optimized|
| RAM Memory | 8 GB | 16 GB |
| Hard Disk | 200 GB SSD | 300 GB SSD |
| IOPs | ----- | 70,000 IOPS READ  50,000 IOPS WRITE |

* **Kubernetes**: Google Kubernestes Engine GKE.

It is necessary to enable the following network ports in the machine in which we are going to deploy the node:

* **Tessera Node - component for private transactions**: 
  * **4040**: TCP - Port to communicate with other Tessera nodes.
  
  * **4444**: TCP - Port for communication between Besu and Tessera.


## Pre-requisites

### Install Kubectl ###

For this installation we will use Kubectl. It is necessary to install Kubectl on a **local machine** that will perform the installation of the node on a **kubernetes cluster**.

Following the instructions to [install kubectl](https://kubernetes.io/docs/tasks/tools/) in your local machine.

### Install Helm ###

For this installation we will use Helm. It is necessary to install helm on a **local machine** that will perform the installation of the node on a **kubernetes cluster**.

Following the instructions to [install helm](https://helm.sh/docs/intro/install/) in your local machine.

### Clone Repository ####

To configure and install Besu and Tessera, you must clone this git repository in your **local machine**.

```shell
$ git clone https://github.com/LACNetNetworks/besu-networks
$ cd besu-networks/helm/
```



## Node Installation ##

### Preparing installation of a new tessera node ###

* That can be created private network in the blockchain networks orchestrated by LACNet at this moment.

### Values variable ###

* Set  values in **tessera.yml**.
*  The values ​​you have to set are in the **deploy** section. These are the following:

* **Values**:

  * **network**:    Type Network  - david19-net | protest-net | main-net.

  * **typenode**:   Type of Node  - tessera 

  * **publicIP**:   TCP Public IP Ingress.

  * **p2p - host**: P2P Public IP Egress.  

  * **p2p - port**: P2P PORT  - Default (60606).

  * **workerName**: Name of the node worker where always the pod will be installed.

  * **dnsName**:    Organization domain name (e.g. lacchain.com). 

  * **nodeName**:   Name you want for your node in the network monitoring tool.

  * **nodeEmail**:  email address you want to register for your node in the network monitoring tool. It's a good idea to provide the e-mail of the technical contact identified or to be identified in the registration form as part of the on-boarding process.

  * **tessera: peer**: Another tessera node of the private network.


### Set value to environment variable ###
* **TCP Public IP Ingress**: Generate a *_static public IP_* in your cloud provider. Then replace the public ip in the load balance *_(loadBalancerIP)_* service manifest. finally update the **publicIP** environment variable with this IP.

* **P2P Public IP Egress**: Outgoing p2p traffic to synchronize besu nodes. This is the permissioned IP for the  network. Therefore, the pod must always be installed on the same worker node so that the IP does not change.
We obtain the name and IP of the cluster nodes with the following command.
    
    $ kubectl get nodes -o wide

![workers](/docs/images/workes-k8s.PNG)

 We choose a worker and update the **"nodeName"** value in the manifest of the pod we are going to deploy. finally update the **p2p - host** environment variable with worker IP external .
 
 <span style="color:yellow "> *_Note:  We validate that the pod has been deployed in the selected worker with the following command._*<span> 
    
    $ kubectl get pod -o wide 



### Deploying the new Tessera node ###

* You need  execute  the following command:

    <span style="color:yellow "> Note: This deployment is compalitible only  Google Kubernestes Engine GKE<span> 



 * To deploy a **Node Tessera**     
      
      ```shell
      $ helm install <chart-name>  ./charts/besu-node --namespace  <namespace-name> --create-namespace --values ./values/tessera.yml 
    
      ```


* e.g. deploy **Node Tessera** on **Mainnet-Omega**  network
 
    ```shell
      $ helm install lacnet-tessera-1 ./charts/besu-node --namespace  lacchain-main-net --create-namespace --values ./values/tessera.yml
    ```
* At the end of the installation, if everything worked a BESU and Tessera pod will be created managed by kubernetes with **Running** status. Aditional  objects created are namespace, service load balancer, configmap, and volume.

	

Now you can check  log node tessera:

```shell
$ kubectl logs <pod name> -c <container name> -f -n <namespace>
```

You should get something like this:

![Log of latest blocks](/docs/images/log_blocks.PNG)

if you need to update the node, try redeploy the Tessera node:

```shell
$ $ helm upgrade <chart-name> ./charts/besu-node --namespace  <namespace-name>  --values ./values/tessera.yml 
```

If any of these two checks doesn't work, try to restart the tessera pod: 

```shell
$ kubectl delete pod <pod name> -n <namespace>
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
