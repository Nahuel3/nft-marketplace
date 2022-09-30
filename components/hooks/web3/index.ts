import { useHooks } from "@providers/web3/Foxy/foxy"
import { useHookss } from "@providers/web3/Alufis/alufi"
import { useHooksAquans } from "@providers/web3/Aquans/aquans";

//FOXY
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
   const srwRes = hookss.useAccountsAlufis(); 
   return{
    account: srwRes
   }
}

export const useNetworks = () => {
   const hookss = useHookss();
   const srwRes = hookss.useNetworksAlufis(); 
   return{
    network: srwRes
   }
}

export const useListedNftss = () => {
   const hookss = useHookss();
   const srwRes = hookss.useListedNftsAlufis(); 
   return{
      nftsAlufis: srwRes
   }
}

export const useOwnedNftss = () => {
   const hookss = useHookss();
   const srwRes = hookss.useOwnedNftsAlufis(); 
 
   return {
      nftsAlufis: srwRes
   }
 }

  //AQUANS

  export const useAccountsAquans = () => {
   const hookss = useHooksAquans();
   const srwRes = hookss.useAccountsAquans(); 
   return{
    account: srwRes
   }
}

export const useNetworksAquans = () => {
   const hookss = useHooksAquans();
   const srwRes = hookss.useNetworksAquans(); 
   return{
    network: srwRes
   }
}

export const useListedNftsAquans = () => {
   const hookss = useHooksAquans();
   const srwRes = hookss.useListedNftsAquans(); 
   return{
      nftsAlufis: srwRes
   }
}

export const useOwnedNftsAquans = () => {
   const hookss = useHooksAquans();
   const srwRes = hookss.useOwnedNftsAquans(); 
 
   return {
      nftsAlufis: srwRes
   }
 }