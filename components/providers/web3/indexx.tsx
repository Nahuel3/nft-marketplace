import { MetaMaskInpageProvider } from "@metamask/providers";
import { NftMarketContractSeconds } from "@_types/nftMarketContractSeconds";
import { ethers } from "ethers";
import { createContext, FunctionComponent, useContext, useEffect, useState } from "react"
import { createDefaultStates, createWeb3States, loadContract, Web3States } from "./utils2";


interface Props {
  children: React.ReactNode;
}

const pageReload = () => { window.location.reload();}

const handleAccount = (ethereum:MetaMaskInpageProvider) => async () => {
  const isLocked = !(await ethereum._metamask.isUnlocked());
  if (isLocked) {pageReload();}
}

const setGlobalListeners = (ethereum:MetaMaskInpageProvider) => {
  ethereum.on("chainChanged", pageReload);
  ethereum.on("accountsChanged", handleAccount(ethereum));
}

const removeGlobalListeners = (ethereum:MetaMaskInpageProvider) => {
 ethereum?.removeListener("chainChanged", pageReload);
 ethereum?.removeListener("accountsChanged", handleAccount);
}


const Web3Context = createContext<Web3States>(createDefaultStates());

const Web3Provider: FunctionComponent<Props> = ({ children }) => {
  const [web3Api, setWeb3Api] = useState<Web3States>(createDefaultStates())

  useEffect(() => {
    async function initWeb3() {

      try {

        const provider = new ethers.providers.Web3Provider(window.ethereum as any)
        const contract = await loadContract("NftMarketSeconds", provider)

        const signer = provider.getSigner();
        const signedContract = contract.connect(signer);

        setTimeout(() =>  setGlobalListeners(window.ethereum), 500);

        setWeb3Api(createWeb3States({
          ethereum: window.ethereum,
          provider,
          contract: signedContract as unknown as NftMarketContractSeconds,
          isLoading: false
        }))
      } catch (e:any) {
        console.error("please install web3 WAllet");
        setWeb3Api((api) => createWeb3States({
          ...api as any,
          isLoading: false,
        }))
      }

    }

    initWeb3();
    return () => removeGlobalListeners(window.ethereum);
  }, [])



  return (
    <Web3Context.Provider value={web3Api}>
      {children}
    </Web3Context.Provider>
  )

}

export function useWebs3() {
  return useContext(Web3Context)
}

export function useHooks() {
  const { hooks } = useWebs3();
  return hooks
}

export default Web3Provider;