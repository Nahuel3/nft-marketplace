import {SetupHooksAquans, Web3HooksAquans} from '../../../hooks/web3/setupHooks';
import { MetaMaskInpageProvider } from "@metamask/providers";
import { Contract, ethers, providers } from "ethers";
import { Web3DependenciesAquans } from '@_types/parteAquans/hookAquans';


declare global {
    interface Window {
        ethereum: MetaMaskInpageProvider;
    }
}

type Nullable<T> = {
  [P in keyof T]: T[P] | null;
}

export type Web3StatesAquans = {
    isLoading: boolean;  //true while loading web3State
    hooks: Web3HooksAquans
} & Nullable<Web3DependenciesAquans>

export const createDefaultStateAquans = () => {
    return {
      ethereum: null,
      provider: null,
      contract: null,
      isLoading: true,
      hooks: SetupHooksAquans({isLoading:true} as any)
    }
}   

export const createWeb3StateAquans = ({
  ethereum, provider, contract, isLoading
}: Web3DependenciesAquans) => {
  return {
    ethereum,
    provider,
    contract,
    isLoading,
    hooks: SetupHooksAquans({ ethereum ,provider, contract, isLoading})
  }
}   


const NETWORK_ID = process.env.NEXT_PUBLIC_NETWORK_ID;

export const loadContract = async (name:string, provider: providers.Web3Provider): Promise<Contract> =>{

  if (!NETWORK_ID){
    return Promise.reject("Network ID is not defined");
  }

  const res = await fetch (`/contracts/${name}.json`);
  const Artifact = await res.json();

  
  if (Artifact.networks[NETWORK_ID].address){
    const contract = new ethers.Contract(
        Artifact.networks[NETWORK_ID].address,
        Artifact.abi,
        provider
    )

    return contract
  }else{
    return Promise.reject(`Contract: [${name}] cannot be loaded!`)
  }

}