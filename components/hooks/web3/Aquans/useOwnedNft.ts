
import { ethers } from "ethers";
import useSWR from "swr";
import { useCallback } from "react";
import { CryptoHookFactorys } from "@_types/parteAlufi/hookAlufi";
import { NftAlufi } from "@_types/parteAlufi/nftAlufi";

//deps -> provider, ethereum , contract (web3state)

type useOwnedNftsResponse = {
  listNftAlufis: (tokenId: number, price: string) => Promise<void>
  cancellSellNftsAlufis:(token: number) => Promise<void>
}

type OwnedNftsHookFactory = CryptoHookFactorys<NftAlufi[], useOwnedNftsResponse> 

export type UseOwnedNftsHooksAquans = ReturnType<OwnedNftsHookFactory>

export const hookFactory: OwnedNftsHookFactory = ({contract}) => () => {

  const {data, ...swr} = useSWR(
    contract ? "web3/useOwnedNft" : null,
   async () => {

     const nftsAlufis = [] as NftAlufi[];
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

       
      nftsAlufis.push({
        price: parseFloat(ethers.utils.formatEther(item.price)),
        tokenId: item.tokenId.toNumber(),
        creator: item.creator,
        isListed: item.isListed,
        meta
      })
   
    }
     return nftsAlufis;
    }
  )
  const _contract = contract;
  const listNftAlufis = useCallback (async (tokenId: number, price: string) => {
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

  const cancellSellNftsAlufis = useCallback(async (tokenId: number) => {
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
    listNftAlufis,
    cancellSellNftsAlufis,
    data: data || [],
  
  }
}

