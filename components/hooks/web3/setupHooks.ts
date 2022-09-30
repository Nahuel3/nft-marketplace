
import { Web3Dependencies } from "@_types/parteFoxy/hookFoxy";
import { Web3Dependencies2 } from "../../../types/parteAlufi/hookAlufi";
import { Web3DependenciesAquans } from "@_types/parteAquans/hookAquans";
//FOXY
import { hookFactory as createAccountHook, UseAccountHook } from "./Foxy/useAccount";
import { hookFactory as createNetworkHook, UseNetworkHook } from "./Foxy/useNetwork";
import { hookFactory as createListedNftsHook, UseListedNftsHook } from "./Foxy/useListedNfts";
import { hookFactory as createOwnedNftsHook, UseOwnedNftsHook } from "./Foxy/useOwnedNfts";
//ALUFI
import { hookFactory as createAccountHooks, UseAccountHooks } from "./Alufis/useAccounts";
import { hookFactory as createNetworkHooks, UseNetworkHooks } from "./Alufis/useNetworks";
import { hookFactory as createListedNftsHooks, UseListedNftsHooks } from "./Alufis/useListedNft";
import { hookFactory as createOwnedNftsHooks, UseOwnedNftsHooks } from "./Alufis/useOwnedNft";
//AQUANS
import { hookFactory as createAccountHooksAquans, UseAccountHooksAquans } from "./Aquans/useAccounts";
import { hookFactory as createNetworkHooksAquans, UseNetworkHooksAquans } from "./Aquans/useNetworks";
import { hookFactory as createListedNftsHooksAquans, UseListedNftsHooksAquans } from "./Aquans/useListedNft";
import { hookFactory as createOwnedNftsHooksAquans, UseOwnedNftsHooksAquans } from "./Aquans/useOwnedNft";

//FOXY
export type Web3Hooks = {
    useAccount: UseAccountHook;
    useNetwork: UseNetworkHook;
    useListedNfts: UseListedNftsHook;
    useOwnedNfts: UseOwnedNftsHook;
}

//ALUFI
export type Web3Hookss = {
    useAccountsAlufis: UseAccountHooks;
    useNetworksAlufis: UseNetworkHooks;
    useListedNftsAlufis: UseListedNftsHooks;
    useOwnedNftsAlufis: UseOwnedNftsHooks;
}

//AQUANS
export type Web3HooksAquans = {
    useAccountsAquans: UseAccountHooksAquans;
    useNetworksAquans: UseNetworkHooksAquans;
    useListedNftsAquans: UseListedNftsHooksAquans;
    useOwnedNftsAquans: UseOwnedNftsHooksAquans;
}

//FOXY
export type SetupHooks = {
    (d: Web3Dependencies): Web3Hooks
}

//ALUFI
export type SetupHooks2 = {
    (d: Web3Dependencies2): Web3Hookss
}

//AQUANS
export type SetupHooksAquans = {
    (d: Web3DependenciesAquans): Web3HooksAquans
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
        useAccountsAlufis: createAccountHooks(deps),
        useNetworksAlufis: createNetworkHooks(deps),
        useListedNftsAlufis: createListedNftsHooks(deps),
        useOwnedNftsAlufis: createOwnedNftsHooks(deps),
    }
}

//AQUANS
export const SetupHooksAquans: SetupHooksAquans = (deps) =>{
    return{
        useAccountsAquans: createAccountHooksAquans(deps),
        useNetworksAquans: createNetworkHooksAquans(deps),
        useListedNftsAquans: createListedNftsHooksAquans(deps),
        useOwnedNftsAquans: createOwnedNftsHooksAquans(deps),
    }
}



