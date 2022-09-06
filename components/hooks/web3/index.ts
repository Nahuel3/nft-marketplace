import { useHooks } from "@providers/web3"


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