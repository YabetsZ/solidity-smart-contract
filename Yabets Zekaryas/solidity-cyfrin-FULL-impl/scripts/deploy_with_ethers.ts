// This script deploys the compiled contract using ethers.js.
// Update the contract name below to match the artifact you want to deploy.

import { deploy } from './ethers-lib'

(async () => {
  try {
    const result = await deploy('SimpleStorage', [])
    console.log(`address: ${result.address}`)
  } catch (e) {
    console.log(e.message)
  }
})()