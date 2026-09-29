## Prerequisites
**Node version 20**

Run `npm init`

Run `npm install --save-dev hardhat`

Run `npm install --save-dev @nomicfoundation/hardhat-toolbox`

Run `setup.sh`

**OR**

Run `npm ci`

## Start local blockchain node
### Compile smart contract
Run `npx hardhat compile`

Run `npx hardhat node` at Terminal 1

## Test
Run `npx hardhat test` at different Terminal

## Deploy

Run `npx hardhat run scripts/deploy.cjs --network localhost`

Open new Terminal, run `node src/js/server.js`

Open from browser `localhost:3000`
