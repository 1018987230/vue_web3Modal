<template>
	<div>
		<el-container class="_bg" style="background-color: rgb(12, 31, 74);position: absolute; height: auto;width: 100%;">

			<el-main style="width: 100%;height: auto;display: flex;background-color: rgb(16, 58, 10);height: 100vh;">

				<div
					style="border-radius: 55px;width: 100%; height: auto;background-color: rgb(16, 58, 105);position:relative; margin-top: 5%;text-align: center;">
						
					<div style="display:block;text-align: center;">
						<el-button class="_cardBtn" type="primary" @click="connect">
							<p class="_cardFont">Connect</p>
						</el-button>
						<el-button type="primary" class="_cardBtn" @click="mint">
							<p class="_cardFont">Mint</p>
						</el-button>
						<el-button type="primary" class="_cardBtn" @click="resetApp">
							<p class="_cardFont">reset</p>
						</el-button>
					</div>
				</div>
			</el-main>
		</el-container>
	</div>
</template> 

<script >
import useWallet from '../hook/useWallte';
import { USDT_API } from '../web3/abis';



export default {

	setup() {
		const {
			onConnect,
			connected,
			web3,
			userAddress,
			resetApp,
		} = useWallet();

		//　合约地址（个人私有）
		const USDT_ADDRESS = '0x8955BB98374b05A6423b7Daa8ec8d57A2c4bCdA6'

		let contract = ''

		// 构建合约
		const buildContract = async ()=>{
			contract = await new web3.value.eth.Contract(USDT_API, USDT_ADDRESS) //api就是合约的abi（个人私有）
		}

		// 连接钱包按键，包括两步骤：
		//	1.　调用useWalletzhong的连接函数
		//  2.  构建合约函数
		const connect = async () => {
			await onConnect();
			await buildContract()
			if (connected) {
				console.log('afterConnectdWallet', connected);
			}
		}

		// mint操作，调用合约中的函数
		async function mint() {
			console.log(contract)
			await contract.methods.safeMint().send({ from: userAddress.value, value: 100000000000000 })// 100000000000000是mint价格（个人私有）
			.then((receipt) => {
				console.log(receipt)
			})
		}

		return {
			connect,
			mint,
			resetApp,
		}
	},
}

</script>

<style>


._mintButton {
	margin-top: 100%;
	margin-left: 50px;
	align-items: center;
	width: 270px;
	height: 70px;
	font-size: 40px;
	font-family: serif;
	font-weight: bold;
}

._cardBtn {
	margin-top: 10px;
	margin-bottom: 5px;
	height: 80px;
	width: 240px;
	background-color: rgba(85, 13, 218, 0.747);
	border-radius: 5px;
	color: rgb(16, 58, 105);
}

._cardFont {
	font-size: x-large;
	font-weight: bold;
	color: white;
}
</style>

