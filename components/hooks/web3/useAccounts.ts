import { useEffect } from 'react';

import useSWR from "swr";
import { CryptoHookFactorys } from '@_types/hoooks2';

//deps -> provider, ethereum , contract (web3state)

type useAccountResponse = {
  connect: () => void;
  isLoading:boolean ;
  isInstalled:boolean;
}

type AccountHookFactorys = CryptoHookFactorys<string, useAccountResponse> 

export type UseAccountHooks = ReturnType<AccountHookFactorys>

export const hookFactory: AccountHookFactorys = ({provider, ethereum, isLoading}) => () => {

  const {data, mutate, isValidating, ...swr} = useSWR(
    provider ? "web3/useAccount" : null,
   async () => {

      const accounts = await provider!.listAccounts();   
      const account = accounts[0];
     
      if(!account){
        throw "Cannot retreive account! please, connect to web3 Wallet"
      }

      return account;
    }, {
      revalidateOnFocus: false,
      shouldRetryOnError:false
    }
  )

  useEffect(() => {
   ethereum?.on("accountsChanged",handleAccountChanged)
   return () => {
    ethereum?.removeListener("accountsChanged", handleAccountChanged)
   }
  })

  const handleAccountChanged = (...args: unknown[]) =>{
  const accounts = args[0] as string[];

  if(accounts.length === 0) {
    console.error("please, connect to web3 wallet");
  }else if (accounts[0] !== data){
    mutate(accounts[0])
   }
  }

  const connect = async () => {
    try{
      ethereum?.request({method: "eth_requestAccounts"})
    }catch(e){
      console.error(e)
    }
  }

   return {
    ...swr,
    data,
    isValidating,
    isLoading:isLoading as boolean ,
    isInstalled:ethereum?.isMetaMask || false,
    mutate,
    connect
  }
}

