
import { Web3Dependencies } from "@_types/hooks";
import { Web3Dependencies2 } from "../../../types/hoooks2";
import { hookFactory as createAccountHook, UseAccountHook } from "./useAccount";
import { hookFactory as createNetworkHook, UseNetworkHook } from "./useNetwork";
import { hookFactory as createListedNftsHook, UseListedNftsHook } from "./useListedNfts";
import { hookFactory as createOwnedNftsHook, UseOwnedNftsHook } from "./useOwnedNfts";

import { hookFactory as createAccountHooks, UseAccountHooks } from "./useAccounts";
import { hookFactory as createNetworkHooks, UseNetworkHooks } from "./useNetworks";
import { hookFactory as createListedNftsHooks, UseListedNftsHooks } from "./useListedNft";
import { hookFactory as createOwnedNftsHooks, UseOwnedNftsHooks } from "./useOwnedNft";

export type Web3Hooks = {
    useAccount: UseAccountHook;
    useNetwork: UseNetworkHook;
    useListedNfts: UseListedNftsHook
    useOwnedNfts: UseOwnedNftsHook;
}

export type Web3Hookss = {
    useAccounts: UseAccountHook;
    useNetworks: UseNetworkHook;
    useListedNftss: UseListedNftsHook
    useOwnedNftss: UseOwnedNftsHook;
}

export type SetupHooks = {
    (d: Web3Dependencies): Web3Hooks
}

export type SetupHooks2 = {
    (d: Web3Dependencies2): Web3Hookss
}

export const setupHooks: SetupHooks = (deps) =>{
    return{
        useAccount: createAccountHook(deps),
        useNetwork: createNetworkHook(deps),
        useListedNfts: createListedNftsHook(deps),
        useOwnedNfts: createOwnedNftsHook(deps),
    }
}

export const setupHooks2: SetupHooks2 = (deps) =>{
    return{
        useAccounts: createAccountHooks(deps),
        useNetworks: createNetworkHooks(deps),
        useListedNftss: createListedNftsHooks(deps),
        useOwnedNftss: createOwnedNftsHooks(deps),
    }
}


