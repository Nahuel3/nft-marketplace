import '../styles/globals.css'
import type { AppProps } from 'next/app'
import {BaseLayout, Navbar} from "../components/ui"
import { Web3Provider } from '@providers'


function MyApp({ Component, pageProps }: AppProps) {
  return (
   <>
   <Web3Provider>
    
      <Navbar></Navbar>
      <Component {...pageProps} />
     
   </Web3Provider>
   
   </>
  )
}

export default MyApp
