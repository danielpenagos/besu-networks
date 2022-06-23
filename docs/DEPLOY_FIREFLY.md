# Hyperledger Firefly on Lacchain

Firefly is a complete stack, which provide tools to manage a transaction, deploy smart contracts, APIs and scale secure web3 applications.

More information [here](https://hyperledger.github.io/firefly/).

# Deploying a Firefly Stack on LACChain

* Firefly stack will be executed on docker container using docker-compose. Stack will be executed on another machine, which is different where your LACChain node is running.

## Minimum System Requirements

Recommended hardware features for Besu node:

| Recommended Hardware |
|:---:|
| 2 vCPUs |
| RAM Memory 8 GB |
| Hard Disk 150 GB SSD |

## Pre-requisites

### Clone Repository ####

To configure and deploy Firefly, you must clone this git repository on your **machine**.

```shell
$ git clone https://github.com/LACNet-Networks/besu-networks
$ cd besu-networks/firefly
```

### Install Docker and Docker compose ###

Docker and Docker-compose installed on machine.

Following the instructions to [install docker](https://docs.docker.com/engine/install/centos/) and [docker-compose](https://docs.docker.com/compose/install/) depending on your operating system.

### Install node and yarn

For this part you will need to have *nodejs* installed. Check whether node is installed on your local computer by running the following command:

```shell
$ node --version
```
If the command doesn’t return a version number, download and install node by following the instructions for the operating system you use on the [Node.js](https://nodejs.org/es/download/) website. Node version should be at least v14.

Check whether yarn is installed on your local computer by running the following command:
```shell
$ yarn --version
```

If the command doesn’t return a version number, download and install yarn by running the following command:
```shell
$ npm install -g yarn
```

## Deploy Firefly ##

### Preparing installation###

Now download all the necessary dependencies
```shell
$ cd besu-networks/firefly
$ yarn install
```

Now, we are going to generate a private key and a keyFile to send transactions to the LACChain network.

To deploy firefly on **Mainnet** network run
```shell
$ node prepareDocker.js --nodeIp=<YOUR_NODE_IP> --network=mainnet --nodeAddress=<YOUR_NODE_ADDRESS>
```
To deploy firefly on **Pro-testnet** network run
```shell
It is not available on pro-testnet
```
To deploy firefly on **David19** network run
```shell
$ node prepareDocker.js --nodeIp=<YOUR_NODE_IP> --network=david19 --nodeAddress=<YOUR_NODE_ADDRESS>
```
Where:
* YOUR_NODE_IP: IP of your node deployed
* YOUR_NODE_ADDRESS: node address located on /lacchain/data/nodeAddress file


Set your organization and node name in firefly.core file:
```shell
$ cd besu-networks/firefly/firefly_core
$ nano firefly.core
```
Edit firefly.core 
```yaml
...
node:
  name: <YOUR_NODE_NAME>
org:
  name: <YOUR ORGANIZACION NAME>
...
```

Finally, run the containers.
```shell
$ docker-compose up -d
```

Wait for firefly to finish syncing the entire chain to pass next step.

To verify the stack is almost synchronized, you are able to see logs:

```shell
$ docker logs -f ethconnect
```

```log
ethconnect      | [2022-06-16T22:38:26.623Z] DEBUG es-65686ba2-29f3-4cd2-4e98-779562a892b5: New checkpoint HWM: 571750
ethconnect      | [2022-06-16T22:38:27.769Z] DEBUG sb-8f580449-6288-4ae5-7724-cd84d40f7e14:BatchPin(address,uint256,string,bytes32,bytes32,string,bytes32[]): new filter. Head=571905 Position=571750 Gap=155 (catchup threshold: 250)
```

New checkpoint HWM: 571750 refers the block 571,750 was synchronized

### Register your Identity

* Execute the following command to register your node identity on smart contract:
```shell
curl -X POST -H 'content-type:application/json' --data '{}' http://localhost:5000/api/v1/network/organizations/self\?confirm\=true
```
It could take a few minutes to register your identity. Result of this command should be similar like this:

{"id":"d16f0a0e-a24b-4596-9a01-fd6f103aad05","did":"did:firefly:org/XXXXXX","type":"org","namespace":"ff_system","name":"XXXX","messages":{"claim":"8dbc7002-b647-40ea-abd3-43b12838c57d","verification":null,"update":null},"created":"2022-06-16T22:39:28.674387388Z","updated":"2022-06-16T22:39:28.674387388Z"}

### Init Token events

* Execute the following command to init token events:
```shell
curl -X POST -H 'content-type:application/json' http://localhost:5108/api/v1/init
```

It is done!. Now you can access using these urls:

http://localhost:5000/ui    --->  Firefly monitor (to monitor your stack and transactions)
http://localhost:5109/home  --->  Firefly sandbox (to deploy tokens and custom smart contracts)

## Additional Configurations ##
If you want you can change the configuration values ​​of each component, they are located in the following files:
* Ethconnect : /firefly/ethconnect_config/config.yaml
* Firefly : /firefly/firefly_core/firefly.core