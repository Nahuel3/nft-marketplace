// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NftMarketSeconds is ERC721URIStorage, Ownable {
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
    uint256 private TokenIdAlufisMistico = 0; //96
    uint256 private TokenIdAlufisMagico = 8; //104
    uint256 private TokenIdAlufisGlorioso = 112;
    uint256 private TokenIdAlufisLegendario = 120;
    uint256 private TokenIdAlufisEpico = 128;
    uint256 private TokenIdAlufisInmortal = 136;
    //mujeres
    uint256 private TokenIdAlufisMisticoWoman = 144;
    uint256 private TokenIdAlufisMagicoWoman = 152;
    uint256 private TokenIdAlufisGloriosoWoman = 160;
    uint256 private TokenIdAlufisLegendarioWoman = 168;
    uint256 private TokenIdAlufisEpicoWoman = 176;
    uint256 private TokenIdAlufisInmortalWoman = 184;

    uint256 private maxAlufiMistico = 7;
    uint256 private maxAlufiMagico = 15;
    uint256 private maxAlufiGlorioso= 10000;
    uint256 private maxAlufiLegendario= 10000;
    uint256 private maxAlufiEpico= 10000;
    uint256 private maxAlufiInmortal= 10000;
    uint256 private maxAlufiMisticoWoman = 15;
    uint256 private maxAlufiMagicoWoman= 31;
    uint256 private maxAlufiGloriosoWoman= 12000;
    uint256 private maxAlufiLegendarioWoman= 12000;
    uint256 private maxAlufiEpicoWoman= 12000;
    uint256 private maxAlufiInmortalWoman= 12000;


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

    constructor() ERC721("SCNFT", "SNFT") {
       
    }

    function setMaxAlufisMistico(uint newMaxAlufis) external onlyOwner {
     require(newMaxAlufis > maxAlufiMistico, "the amount of Alufis must be greater than the existing one");
     maxAlufiMistico = newMaxAlufis;
    }

    function setMaxAlufisMagico(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiMagico, "the amount of Alufis must be greater than the existing one");
     maxAlufiMagico = newMaxAlufi;
    }

    function setMaxAlufisGlorioso(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiGlorioso, "the amount of Alufis must be greater than the existing one");
     maxAlufiGlorioso = newMaxAlufi;
    }

    function setMaxAlufisLegendario(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiLegendario, "the amount of Alufis must be greater than the existing one");
     maxAlufiLegendario = newMaxAlufi;
    }

    function setMaxAlufisEpico(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiEpico, "the amount of Alufis must be greater than the existing one");
     maxAlufiEpico = newMaxAlufi;
    }

    function setMaxAlufisInmortal(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiInmortal, "the amount of Alufis must be greater than the existing one");
     maxAlufiInmortal = newMaxAlufi;
    }

    function setMaxAlufisMisticoWoman(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiMisticoWoman, "the amount of AlufisWoman must be greater than the existing one");
     maxAlufiMisticoWoman = newMaxAlufi;
    }

    function setMaxAlufisMagicoWoman(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiMagicoWoman, "the amount of AlufisWoman must be greater than the existing one");
     maxAlufiMagicoWoman = newMaxAlufi;
    }

    function setMaxAlufisGloriosoWoman(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiGloriosoWoman, "the amount of AlufisWoman must be greater than the existing one");
     maxAlufiGloriosoWoman = newMaxAlufi;
    }

    function setMaxAlufisLegendarioWoman(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiLegendarioWoman, "the amount of AlufisWoman must be greater than the existing one");
     maxAlufiLegendarioWoman = newMaxAlufi;
    }

    function setMaxAlufisEpicoWoman(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiEpicoWoman, "the amount of AlufisWoman must be greater than the existing one");
     maxAlufiEpicoWoman = newMaxAlufi;
    }

    function setMaxAlufisInmortalWoman(uint newMaxAlufi) external onlyOwner {
     require(newMaxAlufi > maxAlufiInmortalWoman, "the amount of AlufisWoman must be greater than the existing one");
     maxAlufiInmortalWoman = newMaxAlufi;
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
  

    function AlufisBuyMistico(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceMistico,
            "Price must be equal to listing price"
        );

        require(TokenIdAlufisMistico < maxAlufiMistico, "Max AlufisMistico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisMistico);
        _createNftItem(TokenIdAlufisMistico);
         TokenIdAlufisMistico += 1;
     }      
           
        return TokenIdAlufisMistico;
    }

    function AlufisBuyMagico(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceMagico,
            "Price must be equal to listing price"
        );       

        require(TokenIdAlufisMagico < maxAlufiMagico, "Max AlufisMagico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisMagico);
        _createNftItem(TokenIdAlufisMagico);
        TokenIdAlufisMagico += 1;
     }      
           
        return TokenIdAlufisMagico;
    }

    function AlufisBuyGlorioso(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceGlorioso,
            "Price must be equal to listing price"
        );       

        require(TokenIdAlufisGlorioso < maxAlufiGlorioso, "Max AlufisGlorioso Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisGlorioso);
        _createNftItem(TokenIdAlufisGlorioso);
        TokenIdAlufisGlorioso += 1;
     }      
           
        return TokenIdAlufisGlorioso;
    }

    function AlufisBuyLegendario (uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceLegendario,
            "Price must be equal to listing price"
        );       

        require(TokenIdAlufisLegendario < maxAlufiLegendario, "Max AlufisLegendario Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisLegendario);
        _createNftItem(TokenIdAlufisLegendario);
        TokenIdAlufisLegendario += 1;
     }      
           
        return TokenIdAlufisLegendario;
    }

        function AlufisBuyEpico(uint amount)
            public
            payable
            returns (uint256)
        {
            
            require(
                msg.value == listingPriceEpico,
                "Price must be equal to listing price"
            );          

        

        require(TokenIdAlufisEpico < maxAlufiEpico, "Max AlufisEpico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisEpico);
        _createNftItem(TokenIdAlufisEpico);
        TokenIdAlufisLegendario += 1;
        }      
            
            return TokenIdAlufisEpico;
        }

        function AlufisBuyInmortal(uint amount)
            public
            payable
            returns (uint256)
        {
            
            require(
                msg.value == listingPriceInmortal,
                "Price must be equal to listing price"
            );
                     
        require(TokenIdAlufisInmortal < maxAlufiInmortal, "Max AlufisInmortal Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisInmortal);
        _createNftItem(TokenIdAlufisInmortal);
        TokenIdAlufisInmortal += 1;
        }      
            
            return TokenIdAlufisInmortal;
        }


function AlufisBuyMisticoWoman(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceMistico,
            "Price must be equal to listing price"
        );

        require(TokenIdAlufisMisticoWoman < maxAlufiMisticoWoman, "Max AlufisMistico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisMisticoWoman);
        _createNftItem(TokenIdAlufisMisticoWoman);
         TokenIdAlufisMisticoWoman += 1;
     }      
           
        return TokenIdAlufisMisticoWoman;
    }

    function AlufisBuyMagicoWoman(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceMagico,
            "Price must be equal to listing price"
        );       

        require(TokenIdAlufisMagicoWoman < maxAlufiMagicoWoman, "Max AlufisMagico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisMagicoWoman);
        _createNftItem(TokenIdAlufisMagicoWoman);
        TokenIdAlufisMagicoWoman += 1;
     }      
           
        return TokenIdAlufisMagicoWoman;
    }

    function AlufisBuyGloriosoWoman(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceGlorioso,
            "Price must be equal to listing price"
        );       

        require(TokenIdAlufisGloriosoWoman < maxAlufiGloriosoWoman, "Max AlufisGlorioso Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisGloriosoWoman);
        _createNftItem(TokenIdAlufisGloriosoWoman);
        TokenIdAlufisGloriosoWoman += 1;
     }      
           
        return TokenIdAlufisGloriosoWoman;
    }

       function AlufisBuyLegendarioWoman (uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPriceLegendario,
            "Price must be equal to listing price"
        );       

        require(TokenIdAlufisLegendarioWoman < maxAlufiLegendarioWoman, "Max AlufisLegendario Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisLegendarioWoman);
        _createNftItem(TokenIdAlufisLegendarioWoman);
        TokenIdAlufisLegendarioWoman += 1;
     }      
           
        return TokenIdAlufisLegendarioWoman;
    }

        function AlufisBuyEpicoWoman(uint amount)
            public
            payable
            returns (uint256)
        {
            
            require(
                msg.value == listingPriceEpico,
                "Price must be equal to listing price"
            );          

        

        require(TokenIdAlufisEpicoWoman < maxAlufiEpicoWoman, "Max AlufisEpico Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisEpicoWoman);
        _createNftItem(TokenIdAlufisEpicoWoman);
        TokenIdAlufisLegendarioWoman += 1;
        }      
            
            return TokenIdAlufisEpicoWoman;
        }

        function AlufisBuyInmortalWoman(uint amount)
            public
            payable
            returns (uint256)
        {
            
      require(
                msg.value == listingPriceInmortal,
                "Price must be equal to listing price"
          );
             
        require(TokenIdAlufisInmortalWoman < maxAlufiInmortalWoman, "Max AlufisInmortal Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, TokenIdAlufisInmortalWoman);
        _createNftItem(TokenIdAlufisInmortalWoman);
        TokenIdAlufisInmortalWoman += 1;
        }      
            
         return TokenIdAlufisInmortalWoman;
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
