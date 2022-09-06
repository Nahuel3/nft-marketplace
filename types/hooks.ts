import { NftMarketContract } from './nftMarketContract';
import { MetaMaskInpageProvider } from '@metamask/providers';
import { Contract } from 'ethers';
import { providers } from 'ethers';
import { SWRResponse } from 'swr';

export type Web3Dependencies = {
    provider: providers.Web3Provider;
    contract: NftMarketContract;
    ethereum: MetaMaskInpageProvider;
    isLoading:boolean;
}

export type CryptoHookFactory<D = any, R = any, P = any> = {
    (d: Partial<Web3Dependencies>): CryptoHandlerHook<D, R, P>
  }
  
  export type CryptoHandlerHook<D = any, R = any, P = any> = (params?: P) => CryptoSWRResponse<D, R>
  
  export type CryptoSWRResponse<D = any, R = any> = SWRResponse<D> & R;

//export type CryptoHookFactory<D = any, P = any> = {
//    (d: Partial<Web3Dependecies>): (params: P) => SWRResponse<D>
//}

