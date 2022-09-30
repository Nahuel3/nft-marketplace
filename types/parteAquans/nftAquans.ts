export type Trait = "Health" | "Speed" | "Defense" | "Melee damage" | "Magic damage" | "Ability pepe"|"Ability air" |"Ability water" |"Ability fire" ;

export type NftAttribute = {
  trait_type: Trait;
  value: string;
}

export type NftMeta = {
  name: string;
  description: string;
  image: string;
  attributes: NftAttribute[];
}

export type NftCore = {
  tokenId: number;
  price: number;
  creator: string;
  isListed: boolean
}

export type NftAquans = {
  meta: NftMeta
} & NftCore

export type FileReq = {
  bytes: Uint8Array;
  contentType: string;
  fileName: string;
}

export type PinataRes = {
  IpfsHash: string;
  PinSize: number;
  Timestamp: string;
  isDuplicate: boolean;
}