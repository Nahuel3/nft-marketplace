/* eslint-disable @next/next/no-img-element */
import { useListedNfts, useListedNftss } from "@hooks/web3";
import { FunctionComponent } from "react";
import NftItem from "../item/itemFoxy";
import NftItemAlufi from "../item/itemAlufi";

const NftList: FunctionComponent = () => {

//const {nfts} = useListedNfts();
const {nftsAlufis} = useListedNftss();
    return (
        <div className="mt-12 max-w-lg mx-auto grid gap-5 lg:grid-cols-3 lg:max-w-none">
 
                {
                 nftsAlufis.data?.map(nft =>
                    <div key={nft.meta.image} className="flex flex-col rounded-lg shadow-lg overflow-hidden">
                        <NftItemAlufi
                          item={nft}
                          buyNftAlufis={nftsAlufis.buyNftAlufis}
                        />
                    </div>
                )}
                


        </div>
    )

}

export default NftList

