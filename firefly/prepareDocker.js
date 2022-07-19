const fs = require('fs')
const path = require('path')
const Web3 = require('web3')
const nunjucks = require('nunjucks')
var minimist = require('minimist')
//var Accounts = require('web3-eth-accounts');

// Web3 initialization (should point to the JSON-RPC endpoint)
const web3 = new Web3(new Web3.providers.HttpProvider('http://127.0.0.1:8590'));

const account = web3.eth.accounts.create();
const address = account.address.substring(2);

var V3KeyStore = web3.eth.accounts.encrypt(account.privateKey, "password");

const tomlFile = '[metadata]\r\ncreatedAt = 2022-06-14T08:15:30-05:00\r\ndescription = "File based configuration"\r\n\r\n[signing]\r\ntype = "file-based-signer"\r\nkey-file = "/data/keystore/'+address.toLowerCase()+'.keyfile"\r\npassword-file = "/data/keystore/password"'

try {
    fs.writeFileSync('./ethsigner_data/keystore/'+address.toLowerCase()+'.keyfile', JSON.stringify(V3KeyStore));
    fs.writeFileSync('./ethsigner_data/keystore/'+address.toLowerCase()+'.toml', tomlFile);
} catch (err) {
    console.error(err);
}

var args = minimist(process.argv.slice(2),{
    string: ['nodeIp', 'network','nodeAddress'],
})


console.log(args);

var network = 648530;
var fireflyContract = "0xcDc9Eff994428ed1Db80e6CA5EC6A13eF49a5fB8";
var factoryContract = "0x08050394591e6FCd81004bf2878945b0Eb39d119";

if (args.network === 'protestnet'){
    network = 648529;
    fireflyContract = "0x0000000000000000000000000000000000000000";
    factoryContract = "0x0000000000000000000000000000000000000000";
} else if (args.network === 'mainnet'){
    network = 648541;
    fireflyContract = "0xc7Dd9bcb9F27F13AefB8143EC5EadCd5aee7969D";
    factoryContract = "0x0a21694e21A7fB0F894abD7022770572f601ED0F";
}

try {
    fs.mkdirSync(path.join(__dirname, "firefly_core"));
} catch (err){
    console.error(err);
}

try {
    nunjucks.configure( { autoescape: true });
    const res = nunjucks.render('firefly.template', { key: account.address.toLowerCase(), instance: fireflyContract });
    fs.writeFileSync('./firefly_core/firefly.core', res);
} catch (err){
    console.error(err);
}

try {
    nunjucks.configure( { autoescape: true });
    const res = nunjucks.render('docker-compose.template', { networkid: network, nodeaddress: args.nodeAddress, nodeip: args.nodeIp, factory: factoryContract });
    fs.writeFileSync('./docker-compose.yml', res);
} catch (err){
    console.error(err);
}

process.exit();
