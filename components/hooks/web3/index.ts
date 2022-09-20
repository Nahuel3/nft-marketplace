import { useHooks } from "@providers/web3/index"
import { useHookss } from "@providers/web3/indexx"


export const useAccount = () => {
   const hooks = useHooks();
   const srwRes = hooks.useAccount(); 
   return{
    account: srwRes
   }
}

export const useNetwork = () => {
   const hooks = useHooks();
   const srwRes = hooks.useNetwork(); 
   return{
    network: srwRes
   }
}

export const useListedNfts = () => {
   const hooks = useHooks();
   const srwRes = hooks.useListedNfts(); 
   return{
    nfts: srwRes
   }
}

export const useOwnedNfts = () => {
   const hooks = useHooks();
   const swrRes = hooks.useOwnedNfts();
 
   return {
     nfts: swrRes
   }
 }

 //ALUFIS

 export const useAccounts = () => {
   const hookss = useHookss();
   const srwRes = hookss.useAccounts(); 
   return{
    account: srwRes
   }
}

export const useNetworks = () => {
   const hookss = useHookss();
   const srwRes = hookss.useNetworks(); 
   return{
    network: srwRes
   }
}

export const useListedNftss = () => {
   const hookss = useHookss();
   const srwRes = hookss.useListedNftss(); 
   return{
      nftsAlufis: srwRes
   }
}

export const useOwnedNftss = () => {
   const hookss = useHookss();
   const srwRes = hookss.useOwnedNftss(); 
 
   return {
      nftsAlufis: srwRes
   }
 }