import {
  ContractTransaction,
  ContractInterface,
  BytesLike as Arrayish,
  BigNumber,
  BigNumberish,
} from 'ethers';
import { EthersContractContextV5 } from 'ethereum-abi-types-generator';

export type ContractContext = EthersContractContextV5<
  NftMarketContract,
  NftMarketContractMethodNames,
  NftMarketContractEventsContext,
  NftMarketContractEvents
>;

export declare type EventFilter = {
  address?: string;
  topics?: Array<string>;
  fromBlock?: string | number;
  toBlock?: string | number;
};

export interface ContractTransactionOverrides {
  /**
   * The maximum units of gas for the transaction to use
   */
  gasLimit?: number;
  /**
   * The price (in wei) per unit of gas
   */
  gasPrice?: BigNumber | string | number | Promise<any>;
  /**
   * The nonce to use in the transaction
   */
  nonce?: number;
  /**
   * The amount to send with the transaction (i.e. msg.value)
   */
  value?: BigNumber | string | number | Promise<any>;
  /**
   * The chain ID (or network ID) to use
   */
  chainId?: number;
}

export interface ContractCallOverrides {
  /**
   * The address to execute the call as
   */
  from?: string;
  /**
   * The maximum units of gas for the transaction to use
   */
  gasLimit?: number;
}
export type NftMarketContractEvents =
  | 'Approval'
  | 'ApprovalForAll'
  | 'NftItemCreated'
  | 'OwnershipTransferred'
  | 'Transfer';
export interface NftMarketContractEventsContext {
  Approval(...parameters: any): EventFilter;
  ApprovalForAll(...parameters: any): EventFilter;
  NftItemCreated(...parameters: any): EventFilter;
  OwnershipTransferred(...parameters: any): EventFilter;
  Transfer(...parameters: any): EventFilter;
}
export type NftMarketContractMethodNames =
  | 'new'
  | '_GruopFoxy'
  | '_idToNftItem'
  | 'approve'
  | 'balanceOf'
  | 'baseURI'
  | 'foxyEpico'
  | 'foxyEpicoWoman'
  | 'foxyGlorioso'
  | 'foxyGloriosoWoman'
  | 'foxyInmortal'
  | 'foxyInmortalWoman'
  | 'foxyLegendario'
  | 'foxyLegendarioWoman'
  | 'foxyMagico'
  | 'foxyMagicoWoman'
  | 'foxyMistico'
  | 'foxyMisticoWoman'
  | 'getApproved'
  | 'isApprovedForAll'
  | 'name'
  | 'owner'
  | 'ownerOf'
  | 'renounceOwnership'
  | 'safeTransferFrom'
  | 'safeTransferFrom'
  | 'setApprovalForAll'
  | 'supportsInterface'
  | 'symbol'
  | 'transferFrom'
  | 'transferOwnership'
  | 'setMaxFoxysMistico'
  | 'setMaxFoxysMagico'
  | 'setMaxFoxysGlorioso'
  | 'setMaxFoxysLegendario'
  | 'setMaxFoxysEpico'
  | 'setMaxFoxysInmortal'
  | 'setMaxFoxysMisticoWoman'
  | 'setMaxFoxysMagicoWoman'
  | 'setMaxFoxysGloriosoWoman'
  | 'setMaxFoxysLegendarioWoman'
  | 'setMaxFoxysEpicoWoman'
  | 'setMaxFoxysInmortalWoman'
  | 'withdraw'
  | 'listedItemsCount'
  | 'totalSupply'
  | 'setBaseURI'
  | 'tokenByIndex'
  | 'tokenOfOwnerByIndex'
  | 'getAllNftsOnSale'
  | 'getOwnedNfts'
  | 'foxyBuyMistico'
  | 'foxyBuyMagico'
  | 'foxyBuyGlorioso'
  | 'foxyBuyLegendario'
  | 'foxyBuyEpico'
  | 'FoxyBuyInmortal'
  | 'tokenURI'
  | 'buyNft'
  | 'cancellSellNft'
  | 'placeNftOnSale';
export interface ApprovalEventEmittedResponse {
  owner: string;
  approved: string;
  tokenId: BigNumberish;
}
export interface ApprovalForAllEventEmittedResponse {
  owner: string;
  operator: string;
  approved: boolean;
}
export interface NftItemCreatedEventEmittedResponse {
  tokenId: BigNumberish;
  price: BigNumberish;
  creator: string;
  isListed: boolean;
}
export interface OwnershipTransferredEventEmittedResponse {
  previousOwner: string;
  newOwner: string;
}
export interface TransferEventEmittedResponse {
  from: string;
  to: string;
  tokenId: BigNumberish;
}
export interface _GruopFoxyResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface _idToNftItemResponse {
  tokenId: BigNumber;
  0: BigNumber;
  price: BigNumber;
  1: BigNumber;
  creator: string;
  2: string;
  isListed: boolean;
  3: boolean;
  length: 4;
}
export interface FoxyEpicoResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyEpicoWomanResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyGloriosoResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyGloriosoWomanResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyInmortalResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyInmortalWomanResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyLegendarioResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyLegendarioWomanResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyMagicoResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyMagicoWomanResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyMisticoResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface FoxyMisticoWomanResponse {
  listingPriceMistico: BigNumber;
  0: BigNumber;
  startTokenId: number;
  1: number;
  endTokenId: number;
  2: number;
  razaNft: string;
  3: string;
  length: 4;
}
export interface NftitemResponse {
  tokenId: BigNumber;
  0: BigNumber;
  price: BigNumber;
  1: BigNumber;
  creator: string;
  2: string;
  isListed: boolean;
  3: boolean;
}
export interface NftMarketContract {
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: constructor
   */
  'new'(overrides?: ContractTransactionOverrides): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   * @param parameter0 Type: uint256, Indexed: false
   */
  _GruopFoxy(
    parameter0: BigNumberish,
    overrides?: ContractCallOverrides
  ): Promise<_GruopFoxyResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   * @param parameter0 Type: uint256, Indexed: false
   */
  _idToNftItem(
    parameter0: BigNumberish,
    overrides?: ContractCallOverrides
  ): Promise<_idToNftItemResponse>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param to Type: address, Indexed: false
   * @param tokenId Type: uint256, Indexed: false
   */
  approve(
    to: string,
    tokenId: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   * @param owner Type: address, Indexed: false
   */
  balanceOf(
    owner: string,
    overrides?: ContractCallOverrides
  ): Promise<BigNumber>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  baseURI(overrides?: ContractCallOverrides): Promise<string>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyEpico(overrides?: ContractCallOverrides): Promise<FoxyEpicoResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyEpicoWoman(
    overrides?: ContractCallOverrides
  ): Promise<FoxyEpicoWomanResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyGlorioso(
    overrides?: ContractCallOverrides
  ): Promise<FoxyGloriosoResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyGloriosoWoman(
    overrides?: ContractCallOverrides
  ): Promise<FoxyGloriosoWomanResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyInmortal(
    overrides?: ContractCallOverrides
  ): Promise<FoxyInmortalResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyInmortalWoman(
    overrides?: ContractCallOverrides
  ): Promise<FoxyInmortalWomanResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyLegendario(
    overrides?: ContractCallOverrides
  ): Promise<FoxyLegendarioResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyLegendarioWoman(
    overrides?: ContractCallOverrides
  ): Promise<FoxyLegendarioWomanResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyMagico(overrides?: ContractCallOverrides): Promise<FoxyMagicoResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyMagicoWoman(
    overrides?: ContractCallOverrides
  ): Promise<FoxyMagicoWomanResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyMistico(overrides?: ContractCallOverrides): Promise<FoxyMisticoResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  foxyMisticoWoman(
    overrides?: ContractCallOverrides
  ): Promise<FoxyMisticoWomanResponse>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   * @param tokenId Type: uint256, Indexed: false
   */
  getApproved(
    tokenId: BigNumberish,
    overrides?: ContractCallOverrides
  ): Promise<string>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   * @param owner Type: address, Indexed: false
   * @param operator Type: address, Indexed: false
   */
  isApprovedForAll(
    owner: string,
    operator: string,
    overrides?: ContractCallOverrides
  ): Promise<boolean>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  name(overrides?: ContractCallOverrides): Promise<string>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  owner(overrides?: ContractCallOverrides): Promise<string>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   * @param tokenId Type: uint256, Indexed: false
   */
  ownerOf(
    tokenId: BigNumberish,
    overrides?: ContractCallOverrides
  ): Promise<string>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   */
  renounceOwnership(
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param from Type: address, Indexed: false
   * @param to Type: address, Indexed: false
   * @param tokenId Type: uint256, Indexed: false
   */
  safeTransferFrom(
    from: string,
    to: string,
    tokenId: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param from Type: address, Indexed: false
   * @param to Type: address, Indexed: false
   * @param tokenId Type: uint256, Indexed: false
   * @param data Type: bytes, Indexed: false
   */
  safeTransferFrom(
    from: string,
    to: string,
    tokenId: BigNumberish,
    data: Arrayish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param operator Type: address, Indexed: false
   * @param approved Type: bool, Indexed: false
   */
  setApprovalForAll(
    operator: string,
    approved: boolean,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   * @param interfaceId Type: bytes4, Indexed: false
   */
  supportsInterface(
    interfaceId: Arrayish,
    overrides?: ContractCallOverrides
  ): Promise<boolean>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  symbol(overrides?: ContractCallOverrides): Promise<string>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param from Type: address, Indexed: false
   * @param to Type: address, Indexed: false
   * @param tokenId Type: uint256, Indexed: false
   */
  transferFrom(
    from: string,
    to: string,
    tokenId: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newOwner Type: address, Indexed: false
   */
  transferOwnership(
    newOwner: string,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysMistico(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysMagico(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysGlorioso(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysLegendario(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysEpico(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysInmortal(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysMisticoWoman(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysMagicoWoman(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysGloriosoWoman(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysLegendarioWoman(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysEpicoWoman(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param newMaxFoxy Type: uint16, Indexed: false
   */
  setMaxFoxysInmortalWoman(
    newMaxFoxy: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   */
  withdraw(
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  listedItemsCount(overrides?: ContractCallOverrides): Promise<BigNumber>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  totalSupply(overrides?: ContractCallOverrides): Promise<BigNumber>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param _newBaseURI Type: string, Indexed: false
   */
  setBaseURI(
    _newBaseURI: string,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   * @param index Type: uint256, Indexed: false
   */
  tokenByIndex(
    index: BigNumberish,
    overrides?: ContractCallOverrides
  ): Promise<BigNumber>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   * @param owner Type: address, Indexed: false
   * @param index Type: uint256, Indexed: false
   */
  tokenOfOwnerByIndex(
    owner: string,
    index: BigNumberish,
    overrides?: ContractCallOverrides
  ): Promise<BigNumber>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  getAllNftsOnSale(
    overrides?: ContractCallOverrides
  ): Promise<NftitemResponse[]>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   */
  getOwnedNfts(overrides?: ContractCallOverrides): Promise<NftitemResponse[]>;
  /**
   * Payable: true
   * Constant: false
   * StateMutability: payable
   * Type: function
   * @param amount Type: uint256, Indexed: false
   * @param _raza Type: string, Indexed: false
   */
  foxyBuyMistico(
    amount: BigNumberish,
    _raza: string,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: true
   * Constant: false
   * StateMutability: payable
   * Type: function
   * @param amount Type: uint256, Indexed: false
   * @param _raza Type: string, Indexed: false
   */
  foxyBuyMagico(
    amount: BigNumberish,
    _raza: string,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: true
   * Constant: false
   * StateMutability: payable
   * Type: function
   * @param amount Type: uint256, Indexed: false
   * @param _raza Type: string, Indexed: false
   */
  foxyBuyGlorioso(
    amount: BigNumberish,
    _raza: string,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: true
   * Constant: false
   * StateMutability: payable
   * Type: function
   * @param amount Type: uint256, Indexed: false
   * @param _raza Type: string, Indexed: false
   */
  foxyBuyLegendario(
    amount: BigNumberish,
    _raza: string,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: true
   * Constant: false
   * StateMutability: payable
   * Type: function
   * @param amount Type: uint256, Indexed: false
   * @param _raza Type: string, Indexed: false
   */
  foxyBuyEpico(
    amount: BigNumberish,
    _raza: string,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: true
   * Constant: false
   * StateMutability: payable
   * Type: function
   * @param amount Type: uint256, Indexed: false
   * @param _raza Type: string, Indexed: false
   */
  FoxyBuyInmortal(
    amount: BigNumberish,
    _raza: string,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: true
   * StateMutability: view
   * Type: function
   * @param tokenId Type: uint256, Indexed: false
   */
  tokenURI(
    tokenId: BigNumberish,
    overrides?: ContractCallOverrides
  ): Promise<string>;
  /**
   * Payable: true
   * Constant: false
   * StateMutability: payable
   * Type: function
   * @param tokenId Type: uint256, Indexed: false
   */
  buyNft(
    tokenId: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: false
   * Constant: false
   * StateMutability: nonpayable
   * Type: function
   * @param tokenId Type: uint256, Indexed: false
   */
  cancellSellNft(
    tokenId: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
  /**
   * Payable: true
   * Constant: false
   * StateMutability: payable
   * Type: function
   * @param tokenId Type: uint256, Indexed: false
   * @param newPrice Type: uint256, Indexed: false
   */
  placeNftOnSale(
    tokenId: BigNumberish,
    newPrice: BigNumberish,
    overrides?: ContractTransactionOverrides
  ): Promise<ContractTransaction>;
}
