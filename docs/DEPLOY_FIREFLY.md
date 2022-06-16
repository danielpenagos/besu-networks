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
```shell
$ node createKeyFile.js
```

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

### Register your Identity

* Execute the following command to register your node identity on smart contract:
```shell
curl -X POST -H 'content-type:application/json' --data '{}' http://localhost:5000/api/v1/network/organizations/self\?confirm\=true
```
Result of this command should be similar like this:


### Init Token events

* Execute the following command to init token events:
```shell
curl -X POST -H 'content-type:application/json' http://localhost:5108/api/v1/init
```

It is done!. Now you can access using these urls:

http://localhost:5000/ui    --->  Firefly monitor (to monitor your stack and transactions)
http://localhost:5109/home  --->  Firefly sandbox (to deploy tokens and custom smart contracts)

