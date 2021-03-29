const TokenFarm = artifacts.require('TokenFarm')



//По такой вот штучке влепить курс к ефиру?
module.exports = async function(callback) {
  let tokenFarm = await TokenFarm.deployed()
  await tokenFarm.issueTokens()
  // Code goes here...
  console.log("Tokens issued!")
  callback()
}