import { MetaMaskInpageProvider } from "@metamask/providers";
import { NftMarketContractAquans } from "@_types/nftMarketContractAquans";
import { ethers } from "ethers";
import { createContext, FunctionComponent, useContext, useEffect, useState } from "react"
import { createDefaultStateAquans, createWeb3StateAquans, loadContract, Web3StatesAquans } from "./utilsAquans";


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


const Web3Context = createContext<Web3StatesAquans>(createDefaultStateAquans());

const Web3Providers: FunctionComponent<Props> = ({ children }) => {
  const [web3Api, setWeb3Api] = useState<Web3StatesAquans>(createDefaultStateAquans())

  useEffect(() => {
    async function initWeb3() {

      try {

        const provider = new ethers.providers.Web3Provider(window.ethereum as any)
        const contract = await loadContract("NftMarketAquans", provider)

        const signer = provider.getSigner();
        const signedContract = contract.connect(signer);

        setTimeout(() =>  setGlobalListeners(window.ethereum), 500);

        setWeb3Api(createWeb3StateAquans({
          ethereum: window.ethereum,
          provider,
          contract: signedContract as unknown as NftMarketContractAquans,
          isLoading: false
        }))
      } catch (e:any) {
        console.error("please install web3 WAllet");
        setWeb3Api((api) => createWeb3StateAquans({
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

export function useWebs3Aquans() {
  return useContext(Web3Context)
}

export function useHooksAquans() {
  const { hooks } = useWebs3Aquans();
  return hooks
}

export default Web3Providers;