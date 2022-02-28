## Overview

* LACChain Networks are blockchain networks initially developed within the [LACChain project](https://www.lacchain.net/home) and now orchestrated by the non-profit legal vehicle [LACNet](https://lacnet.lacchain.net/). These networks are classified as permissioned public blockchain infrastructure, as defined by the standard [ISO/TC 307](https://www.iso.org/committee/6266604.html). LACChain Networks follow the [LACChain Framework](https://publications.iadb.org/en/lacchain-framework-permissioned-public-blockchain-networks-blockchain-technology-blockchain).

* As public blockchain networks, LACChain Networks are open to any entity in Latin America and the Caribbean. As permissioned networks, entities must be authenticated and commit to comply with regulation in order to be permissioned. LACChain Networks have no trasaction fees.

* The Testnet networks are free. In order to deploy a node, it is required to file a very short [registration agreement form](https://github.com/LACNetNetworks/besu-networks/blob/master/testnet/agreement_form/agreement_form.md) as well as reading, understing, and agreeing with the terms of reference. 

* The Mainet networks are [membership-based](https://lacnet.lacchain.net/contrata-tu-membresia/). These networks are aimed to ensure relisience and accountability via Service Level Agreements between any entity operating a node and LACNet.

* The nodes in the LACChain networks can be classified into two groups, according to their relevance for the functioning of the network. The two groups are core and satellite nodes. In each of these two groups there are also two different types of nodes, according to the specific taks they can perform. Core nodes are classified into validator and boot nodes, and satellite nodes are classified into writer and observer nodes. For more information you can go to [Topology and Architecture](https://github.com/LACNetNetworks/besu-networks/blob/master/docs/TOPOLOGY_AND_ARCHITECTURE.md).

* The LACChain Networks avaliable in this repository are based on [Hyperledger Besu](https://www.hyperledger.org/projects/besu), an open-source, mainnet compatible, Java based, and Apache 2.0 licensed Ethereum client. For more information you can read the [code](https://github.com/hyperledger/besu) and the [documentation](https://github.com/hyperledger/besu-docs).

* These LACChain Networks use [IBFT2.0](https://besu.hyperledger.org/en/stable/HowTo/Configure/Consensus-Protocols/IBFT/) consensus protocol for the validation of transactions and generation of new blocks. Additionally, we have developed a [protocol to rotate validador nodes](https://github.com/LACNetNetworks/rotation-validator) in a way that maximizes performance and decentralization.

* The GAS is distributed in these networks following the [GAS distribution mechanism](https://github.com/LACNetNetworks/gas-management).

* We have created two guides to help you [Deploy your Dapp on LACChain](https://github.com/LACNetNetworks/besu-networks/blob/master/docs/DEPLOY_APPLICATIONS.md) and [provide your Dapp with a suitable archiecture](https://github.com/LACNetNetworks/besu-networks/blob/master/docs/DAPP_ARCHITECTURE.md). We have also developed [several tutorials](https://github.com/LACNetNetworks/gas-management/tree/master/docs/tutorial) to [deploy your first ERC20 and notarization smart contracts](https://github.com/LACNetNetworks/gas-management/blob/master/docs/tutorial/Deploy_SmartContract.md) as well as more complex smart contracts that implement elements of the [LACChain ID framework](https://publications.iadb.org/en/lacchain-framework-permissioned-public-blockchain-networks-blockchain-technology-blockchain).

* We have also develop some services that allow to check that your nodes are working properly. The [Besu Health Check](https://github.com/lacchain/besu-healthcheck) helps users test interactions with a Besu node by accessing it through RPC. [Node Health Check](https://github.com/lacchain/node-health-check) can be used to guarante availability of the orion transaction manager. These two services are automatically deployed when using the Ansible installation provided below in this document.

* Every entity running a node in the LACChain networks is listed in the [list of permissioned nodes](https://github.com/lacchain/besu-network/blob/master/NODE_LIST.md).

* For additional informations, please check the [FAQ](https://github.com/LACNetNetworks/besu-networks/blob/master/docs/FAQ.md).

## Deploy a node

* To deploy a node in the LACChain Networks orchestrated by LACNet, go [HERE](https://github.com/lacchain/besu-network/blob/master/DEPLOY_NODE.md). 

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
