import WalletConnect from "@walletconnect/web3-provider";
import CoinbaseWalletSDK from "@coinbase/wallet-sdk";
//
const providerOptions = {
  // https://docs.walletconnect.org/
  walletconnect: {
    package: WalletConnect,
    options: {
      infuraId: "a42befff87544ff684b5246140f9a8e7" // required
    }
  },
  coinbasewallet: {
    package: CoinbaseWalletSDK, 
    options: {
      appName: "Web 3 Modal Demo",
      infuraId: "a42befff87544ff684b5246140f9a8e7"
    }
  },

};

export { providerOptions };
