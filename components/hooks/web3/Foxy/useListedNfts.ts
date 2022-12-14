
import { CryptoHookFactory } from "@_types/parteFoxy/hookFoxy";
import { ethers } from "ethers";
import useSWR from "swr";
import { Nft } from "@_types/parteFoxy/nftFoxy";
import { useCallback } from "react";

//deps -> provider, ethereum , contract (web3state)

type UseListedNftsResponse = {
  buyNft: (token: number, value: string) => Promise<void>
 
}


type ListedNftsHookFactory = CryptoHookFactory<Nft[], UseListedNftsResponse> 

export type UseListedNftsHook = ReturnType<ListedNftsHookFactory>

export const hookFactory: ListedNftsHookFactory = ({contract}) => () => {

  const {data, ...swr} = useSWR(
    contract ? "web3/useListedNfts" : null,
   async () => {

     const nfts = [] as Nft[];
     const coreNfts = await contract!.getAllNftsOnSale();
     
     let fixIPFSURL = (url: string) => {
      if (url.startsWith("ipfs")) {
        return "https://" + url.split("ipfs://").slice(-1);
       } else {
         return url + "?format=json";
       }
   };

     for (let i = 0; i < coreNfts.length; i++) {
      const item = coreNfts[i];
      const tokenURI = await contract!.tokenURI(item.tokenId);
      const metaRes = await fetch(fixIPFSURL(tokenURI));
      const meta = await metaRes.json();
    
      
        nfts.push({
          price: parseFloat(ethers.utils.formatEther(item.price)),
          tokenId: item.tokenId.toNumber(),
          creator: item.creator,
          isListed: item.isListed,
          meta
        })
      

          
    }

    return nfts;
    
    }
  )
const _contract = contract;
  const buyNft = useCallback(async (tokenId: number, value: string) => {
    try {
     const result = await _contract!.buyNft(
        tokenId, {
          value: ethers.utils.parseEther(value.toString())
        }
      )
      await result?.wait();
      alert("You have bought Nft. See profile page.")
    } catch (e: any) {
      console.error(e.message);
    }
  }, [_contract])


   return {
    ...swr,
    buyNft,
    
    data: data || [],
  
  }
}

