
import { CryptoHookFactory } from "@_types/parteFoxy/hookFoxy";
import { ethers } from "ethers";
import useSWR from "swr";
import { Nft } from "@_types/parteFoxy/nftFoxy";
import { useCallback } from "react";

//deps -> provider, ethereum , contract (web3state)

type useOwnedNftsResponse = {
  listNft: (tokenId: number, price: string) => Promise<void>
  cancellSellNft:(token: number) => Promise<void>
}

type OwnedNftsHookFactory = CryptoHookFactory<Nft[], useOwnedNftsResponse> 

export type UseOwnedNftsHook = ReturnType<OwnedNftsHookFactory>

export const hookFactory: OwnedNftsHookFactory = ({contract}) => () => {

  const {data, ...swr} = useSWR(
    contract ? "web3/useOwnedNfts" : null,
   async () => {

     const nfts = [] as Nft[];
     const coreNfts = await contract!.getOwnedNfts();

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
  const listNft = useCallback (async (tokenId: number, price: string) => {
    try {
     const result = await _contract!.placeNftOnSale(
        tokenId,
        ethers.utils.parseEther(price.toString()),
         {
          value: ethers.utils.parseEther(0.0025.toString())
        }
      )

      await result?.wait();

      alert("Item has been listed!");
    } catch (e: any) {
      console.error(e.message);
    }
  }, [_contract])

  const cancellSellNft = useCallback(async (tokenId: number) => {
    try {
     const result = await _contract!.cancellSellNft(
        tokenId
      )
      await result?.wait();
      alert("Cancell Nft sell. See profile page.")
    } catch (e: any) {
      console.error(e.message);
    }
  }, [_contract])

   return {
    ...swr,
    listNft,
    cancellSellNft,
    data: data || [],
  
  }
}

