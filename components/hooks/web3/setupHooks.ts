
import { Web3Dependencies } from "@_types/parteFoxy/hookFoxy";
import { Web3Dependencies2 } from "../../../types/parteAlufi/hookAlufi";
import { hookFactory as createAccountHook, UseAccountHook } from "./Foxy/useAccount";
import { hookFactory as createNetworkHook, UseNetworkHook } from "./Foxy/useNetwork";
import { hookFactory as createListedNftsHook, UseListedNftsHook } from "./Foxy/useListedNfts";
import { hookFactory as createOwnedNftsHook, UseOwnedNftsHook } from "./Foxy/useOwnedNfts";

import { hookFactory as createAccountHooks, UseAccountHooks } from "./Alufis/useAccounts";
import { hookFactory as createNetworkHooks, UseNetworkHooks } from "./Alufis/useNetworks";
import { hookFactory as createListedNftsHooks, UseListedNftsHooks } from "./Alufis/useListedNft";
import { hookFactory as createOwnedNftsHooks, UseOwnedNftsHooks } from "./Alufis/useOwnedNft";

//FOXY
export type Web3Hooks = {
    useAccount: UseAccountHook;
    useNetwork: UseNetworkHook;
    useListedNfts: UseListedNftsHook;
    useOwnedNfts: UseOwnedNftsHook;
}

//ALUFI
export type Web3Hookss = {
    useAccounts: UseAccountHooks;
    useNetworks: UseNetworkHooks;
    useListedNftss: UseListedNftsHooks;
    useOwnedNftss: UseOwnedNftsHooks;
}
//FOXY
export type SetupHooks = {
    (d: Web3Dependencies): Web3Hooks
}

//ALUFI
export type SetupHooks2 = {
    (d: Web3Dependencies2): Web3Hookss
}

//FOXY

export const setupHooks: SetupHooks = (deps) =>{
    return{
        useAccount: createAccountHook(deps),
        useNetwork: createNetworkHook(deps),
        useListedNfts: createListedNftsHook(deps),
        useOwnedNfts: createOwnedNftsHook(deps),
    }
}

//ALUFI
export const setupHooks2: SetupHooks2 = (deps) =>{
    return{
        useAccounts: createAccountHooks(deps),
        useNetworks: createNetworkHooks(deps),
        useListedNftss: createListedNftsHooks(deps),
        useOwnedNftss: createOwnedNftsHooks(deps),
    }
}


