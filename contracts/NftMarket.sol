// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NftMarket is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;
    using Address for address;

    struct NftItem {
        uint256 tokenId;
        uint256 price;
        address creator;
        bool isListed;
    }

    uint256 private listingPriceMistico = 0.25 ether;
    uint256 private listingPriceMagico = 0.35 ether;
    uint256 private listingPriceGlorioso = 0.55 ether;
    uint256 private listingPriceLegendario = 0.75 ether;
    uint256 private listingPriceEpico = 1.00 ether;
    uint256 private listingPriceInmortal = 1.25 ether;
    //hombres
    uint256 private TokenIdFoxyMistico = 0;
    uint256 private TokenIdFoxyMagico = 8;  //4000
    uint256 private TokenIdFoxyGlorioso = 8000;
    uint256 private TokenIdFoxyLegendario = 12000;
    uint256 private TokenIdFoxyEpico = 16000;
    uint256 private TokenIdFoxyInmortal = 200000;
    //mujeres
    uint256 private TokenIdFoxyMisticoWoman = 24000;
    uint256 private TokenIdFoxyMagicoWoman = 28000;
    uint256 private TokenIdFoxyGloriosoWoman = 32000;
    uint256 private TokenIdFoxyLegendarioWoman = 36000;
    uint256 private TokenIdFoxyEpicoWoman = 40000;  
    uint256 private TokenIdFoxyInmortalWoman = 44000;

    uint256 private maxFoxyMistico = 7; //2000
    uint256 private maxFoxyMagico = 15; //6000
    uint256 private maxFoxyGlorioso= 10000;
    uint256 private maxFoxyLegendario= 14000;
    uint256 private maxFoxyEpico= 18000;
    uint256 private maxFoxyInmortal= 22000;
    uint256 private maxFoxyMisticoWoman = 26000;
    uint256 private maxFoxyMagicoWoman= 30000;
    uint256 private maxFoxyGloriosoWoman= 34000;
    uint256 private maxFoxyLegendarioWoman= 380000;
    uint256 private maxFoxyEpicoWoman= 42000;
    uint256 private maxFoxyInmortalWoman= 46000;

    Counters.Counter private _listedItems;
    Counters.Counter private _tokenIds;


    string private baseExtension = ".json";
    string private baseURI;

    mapping(string => bool) private _usedTokenURIs;
    mapping(uint256 => NftItem) public _idToNftItem;

    mapping(address => mapping(uint256 => uint256)) private _ownedTokens;
    mapping(uint256 => uint256) private _idToOwnedIndex;

    uint256[] private _allNfts;

    mapping(uint256 => uint256) private _idToNftIndex;

    event NftItemCreated(
        uint256 tokenId,
        uint256 price,
        address creator,
        bool isListed
    );

    constructor() ERC721("ElfNFT", "ENFT") {
       
    }

     function setMaxFoxysMistico(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyMistico, "the amount of foxys must be greater than the existing one");
     maxFoxyMistico = newMaxFoxy;
    }

    function setMaxFoxysMagico(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyMagico, "the amount of foxys must be greater than the existing one");
     maxFoxyMagico = newMaxFoxy;

    }

    function setMaxFoxysGlorioso(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyGlorioso, "the amount of foxys must be greater than the existing one");
     maxFoxyGlorioso = newMaxFoxy;
    }

    function setMaxFoxysLegendario(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyLegendario, "the amount of foxys must be greater than the existing one");
     maxFoxyLegendario = newMaxFoxy;
    }

    function setMaxFoxysEpico(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyEpico, "the amount of foxys must be greater than the existing one");
     maxFoxyEpico = newMaxFoxy;
    }

    function setMaxFoxysInmortal(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyInmortal, "the amount of foxys must be greater than the existing one");
     maxFoxyInmortal = newMaxFoxy;
    }

    function setMaxFoxysMisticoWoman(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyMisticoWoman, "the amount of foxysWoman must be greater than the existing one");
     maxFoxyMisticoWoman = newMaxFoxy;
    }

    function setMaxFoxysMagicoWoman(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyMagicoWoman, "the amount of foxysWoman must be greater than the existing one");
     maxFoxyMagicoWoman = newMaxFoxy;
    }

    function setMaxFoxysGloriosoWoman(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyGloriosoWoman, "the amount of foxysWoman must be greater than the existing one");
     maxFoxyGloriosoWoman = newMaxFoxy;
    }

    function setMaxFoxysLegendarioWoman(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyLegendarioWoman, "the amount of foxysWoman must be greater than the existing one");
     maxFoxyLegendarioWoman = newMaxFoxy;
    }

    function setMaxFoxysEpicoWoman(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyEpicoWoman, "the amount of foxysWoman must be greater than the existing one");
     maxFoxyEpicoWoman = newMaxFoxy;
    }

    function setMaxFoxysInmortalWoman(uint newMaxFoxy) external onlyOwner {
     require(newMaxFoxy > maxFoxyInmortalWoman, "the amount of foxysWoman must be greater than the existing one");
     maxFoxyInmortalWoman = newMaxFoxy;
    }

    function withdraw() external onlyOwner{
     uint256 amount = address(this).balance;
     require(amount > 0, "No funds available");
     address principal = (0x1e8dd1acB4D121d1a30B7B9bb709F2FDaf041Cc2);
     Address.sendValue(payable(principal), amount);
     
    }


    function listedItemsCount() public view returns (uint256) {
        return _listedItems.current();
    }

    function totalSupply() public view returns (uint256) {
        return _allNfts.length;
    }
    

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
     }

     function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(index < totalSupply(), "Index out of bounds");
        return _allNfts[index];
    }

    function tokenOfOwnerByIndex(address owner, uint256 index)
        public
        view
        returns (uint256)
    {
        require(index < ERC721.balanceOf(owner), "Index out of bounds");
        return _ownedTokens[owner][index];
    }

    function getAllNftsOnSale() public view returns (NftItem[] memory) {
        uint256 allItemsCounts = totalSupply();
        uint256 currentIndex = 0;
        NftItem[] memory items = new NftItem[](_listedItems.current());

        for (uint256 i = 0; i < allItemsCounts; i++) {
            uint256 tokenId = tokenByIndex(i);
            NftItem storage item = _idToNftItem[tokenId];

            if (item.isListed == true) {
                items[currentIndex] = item;
                currentIndex += 1;
            }
        }

        return items;
    }

    function getOwnedNfts() public view returns (NftItem[] memory) {
        uint256 ownedItemsCount = ERC721.balanceOf(msg.sender);
        NftItem[] memory items = new NftItem[](ownedItemsCount);

        for (uint256 i = 0; i < ownedItemsCount; i++) {
            uint256 tokenId = tokenOfOwnerByIndex(msg.sender, i);
            NftItem storage item = _idToNftItem[tokenId];
            items[i] = item;
        }

        return items;
    }
  

    function foxyBuyMistico(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceMistico,
            "Price must be equal to listing price"
        );

        require(TokenIdFoxyMistico < maxFoxyMistico, "Max FoxyMistico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyMistico);
        _createNftItem(TokenIdFoxyMistico);
         TokenIdFoxyMistico += 1;
     }      
           
        return TokenIdFoxyMistico;
    }

    function foxyBuyMagico(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceMagico,
            "Price must be equal to listing price"
        );       

        require(TokenIdFoxyMagico < maxFoxyMagico, "Max FoxyMagico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyMagico);
        _createNftItem(TokenIdFoxyMagico);
        TokenIdFoxyMagico += 1;
     }      
           
        return TokenIdFoxyMagico;
    }

    function foxyBuyGlorioso(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceGlorioso,
            "Price must be equal to listing price"
        );       

        require(TokenIdFoxyGlorioso < maxFoxyGlorioso, "Max FoxyGlorioso Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyGlorioso);
        _createNftItem(TokenIdFoxyGlorioso);
        TokenIdFoxyGlorioso += 1;
     }      
           
        return TokenIdFoxyGlorioso;
    }

    function foxyBuyLegendario (uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceLegendario,
            "Price must be equal to listing price"
        );       

        require(TokenIdFoxyLegendario < maxFoxyLegendario, "Max FoxyLegendario Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyLegendario);
        _createNftItem(TokenIdFoxyLegendario);
        TokenIdFoxyLegendario += 1;
     }      
           
        return TokenIdFoxyLegendario;
    }

        function foxyBuyEpico(uint amount)
            public
            payable
            returns (uint256)
        {
            
            require(
                msg.value == listingPriceEpico,
                "Price must be equal to listing price"
            );          

        

        require(TokenIdFoxyEpico < maxFoxyEpico, "Max FoxyEpico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyEpico);
        _createNftItem(TokenIdFoxyEpico);
        TokenIdFoxyLegendario += 1;
        }      
            
            return TokenIdFoxyEpico;
        }

        function FoxyBuyInmortal(uint amount)
            public
            payable
            returns (uint256)
        {
            
            require(
                msg.value == listingPriceInmortal,
                "Price must be equal to listing price"
            );
                     
        require(TokenIdFoxyInmortal < maxFoxyInmortal, "Max FoxyInmortal Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyInmortal);
        _createNftItem(TokenIdFoxyInmortal);
        TokenIdFoxyInmortal += 1;
        }      
            
            return TokenIdFoxyInmortal;
        }


function foxyBuyMisticoWoman(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceMistico,
            "Price must be equal to listing price"
        );

        require(TokenIdFoxyMisticoWoman < maxFoxyMisticoWoman, "Max FoxyMistico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyMisticoWoman);
        _createNftItem(TokenIdFoxyMisticoWoman);
         TokenIdFoxyMisticoWoman += 1;
     }      
           
        return TokenIdFoxyMisticoWoman;
    }

    function foxyBuyMagicoWoman(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceMagico,
            "Price must be equal to listing price"
        );       

        require(TokenIdFoxyMagicoWoman < maxFoxyMagicoWoman, "Max FoxyMagico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyMagicoWoman);
        _createNftItem(TokenIdFoxyMagicoWoman);
        TokenIdFoxyMagicoWoman += 1;
     }      
           
        return TokenIdFoxyMagicoWoman;
    }

    function foxyBuyGloriosoWoman(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceGlorioso,
            "Price must be equal to listing price"
        );       

        require(TokenIdFoxyGloriosoWoman < maxFoxyGloriosoWoman, "Max FoxyGlorioso Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyGloriosoWoman);
        _createNftItem(TokenIdFoxyGloriosoWoman);
        TokenIdFoxyGloriosoWoman += 1;
     }      
           
        return TokenIdFoxyGloriosoWoman;
    }

       function foxyBuyLegendarioWoman (uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceLegendario,
            "Price must be equal to listing price"
        );       

        require(TokenIdFoxyLegendarioWoman < maxFoxyLegendarioWoman, "Max FoxyLegendario Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyLegendarioWoman);
        _createNftItem(TokenIdFoxyLegendarioWoman);
        TokenIdFoxyLegendarioWoman += 1;
     }      
           
        return TokenIdFoxyLegendarioWoman;
    }

        function foxyBuyEpicoWoman(uint amount)
            public
            payable
            returns (uint256)
        {
            
            require(
                msg.value == listingPriceEpico,
                "Price must be equal to listing price"
            );          

        

        require(TokenIdFoxyEpicoWoman < maxFoxyEpicoWoman, "Max FoxyEpico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyEpicoWoman);
        _createNftItem(TokenIdFoxyEpicoWoman);
        TokenIdFoxyLegendarioWoman += 1;
        }      
            
            return TokenIdFoxyEpicoWoman;
        }

        function FoxyBuyInmortalWoman(uint amount)
            public
            payable
            returns (uint256)
        {
            
            require(
                msg.value == listingPriceInmortal,
                "Price must be equal to listing price"
            );
                     
        require(TokenIdFoxyInmortalWoman < maxFoxyInmortalWoman, "Max FoxyInmortal Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdFoxyInmortalWoman);
        _createNftItem(TokenIdFoxyInmortalWoman);
        TokenIdFoxyInmortalWoman += 1;
        }      
            
         return TokenIdFoxyInmortalWoman;
        }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(
            _exists(tokenId)
            );

           string memory currentBaseURI = _baseURI();
         return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI, 
                        tokenId.toString(), 
                        baseExtension 
                    ) 
                )
                : "";

    }

    function buyNft(uint256 tokenId) public payable {
        uint256 price = _idToNftItem[tokenId].price;
        address owner = ERC721.ownerOf(tokenId);

        require(msg.sender != owner, "You already own this NFT");
        require(msg.value == price, "Please submit the asking price");

        _idToNftItem[tokenId].isListed = false;
        _listedItems.decrement();

        _transfer(owner, msg.sender, tokenId);
        Address.sendValue(payable(owner), msg.value);
        
    }

     function cancellSellNft(uint256 tokenId) public  {
        
    require(ERC721.ownerOf(tokenId) == msg.sender, "You are not owner of this nft");
        
    _idToNftItem[tokenId].isListed = false;
    _listedItems.decrement();
     
    }

    function placeNftOnSale(uint tokenId, uint newPrice) public payable {
    require(ERC721.ownerOf(tokenId) == msg.sender, "You are not owner of this nft");
    require(_idToNftItem[tokenId].isListed == false, "Item is already on sale");
    

    _idToNftItem[tokenId].isListed = true;
    _idToNftItem[tokenId].price = newPrice;
    _listedItems.increment();
  }

    function _createNftItem(uint256 tokenId) private {

        _idToNftItem[tokenId] = NftItem(tokenId, listingPriceMistico, msg.sender, false);

        emit NftItemCreated(tokenId, listingPriceMistico, msg.sender, false);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, tokenId);

        // minting token
        if (from == address(0)) {
            _addTokenToAllTokensEnumeration(tokenId);
        } else if (from != to) {
            _removeTokenFromOwnerEnumeration(from, tokenId);
        }
        if (to == address(0)) {
            _removeTokenFromAllTokensEnumeration(tokenId);
        } else if (to != from) {
            _addTokenToOwnerEnumaretion(to, tokenId);
        }
    }

    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _idToNftIndex[tokenId] = _allNfts.length;
        _allNfts.push(tokenId);
    }

    function _addTokenToOwnerEnumaretion(address to, uint256 tokenId) private {
        uint256 length = ERC721.balanceOf(to);
        _ownedTokens[to][length] = tokenId;
        _idToOwnedIndex[tokenId] = length;
    }

    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId)
        private
    {
        uint256 lastTokenIndex = ERC721.balanceOf(from) - 1;
        uint256 tokenIndex = _idToOwnedIndex[tokenId];

        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId;
            _idToOwnedIndex[lastTokenId] = tokenIndex;
        }

        delete _idToOwnedIndex[tokenId];
        delete _ownedTokens[from][lastTokenIndex];
    }

    function _removeTokenFromAllTokensEnumeration(uint tokenId) private {
    uint lastTokenIndex = _allNfts.length - 1;
    uint tokenIndex = _idToNftIndex[tokenId];
    uint lastTokenId = _allNfts[lastTokenIndex];

    _allNfts[tokenIndex] = lastTokenId;
    _idToNftIndex[lastTokenId] = tokenIndex;

    delete _idToNftIndex[tokenId];
    _allNfts.pop();
  }

}
