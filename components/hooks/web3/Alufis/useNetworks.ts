
import { CryptoHookFactorys } from "@_types/parteAlufi/hookAlufi";
import useSWR from "swr";

//deps -> provider, ethereum , contract (web3state)

const NETWORKS: {[k: string]: string} = {
    1: "Ethereum Main Network",
    3: "Ropsten Test Network",
    4: "Rinkeby Test Network",
    5: "Goerli Test Network",
    42: "Kovan Test Network",
    56: "Binance Smart Chain",
    97: "Binance Smart Chain Test",
    1337: "Ganache",
  }

  const targetId = process.env.NEXT_PUBLIC_TARGET_CHAIN_ID as string;
  const targetNetwork = NETWORKS[targetId];

type useNetworkResponse = {

  isLoading:boolean;
  isSupported:boolean;
  targetNetwork:string;
  isConnectedToNetwork: boolean;
}

type NetworkHookFactory = CryptoHookFactorys<string, useNetworkResponse> 

export type UseNetworkHooks = ReturnType<NetworkHookFactory>

export const hookFactory: NetworkHookFactory = ({provider,  isLoading,}) => () => {

  const {data,  isValidating, ...swr} = useSWR(
    provider ? "web3/useNetworks" : null,
   async () => {

    const chainId = (await provider!.getNetwork()).chainId;
      return NETWORKS[chainId];
    }, {
      revalidateOnFocus: false
    }
  )

  const isSupported = data === targetNetwork;

   return {
    ...swr,
    data,
    isValidating,
    targetNetwork,
    isSupported,
    isConnectedToNetwork: !isLoading && isSupported,
    isLoading:isLoading as boolean,
    
  }
}

