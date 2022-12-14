import '../styles/globals.css'
import type { AppProps } from 'next/app'
import {BaseLayout, Navbar} from "../components/ui"
import { Web3Provider } from '@providers' //FOXY
import { Web3Providers } from '@providers' //ALUFI


function MyApp({ Component, pageProps }: AppProps) {
  return (
   <>
   <Web3Provider>
      <Web3Providers>

      <Navbar></Navbar>
      <Component {...pageProps} />
        
      </Web3Providers>
   </Web3Provider>
   
   </>
  )
}

export default MyApp
