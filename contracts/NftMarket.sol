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

    uint256 public listingPrice = 0.25 ether;
    uint256 public maxSupply = 7;

    Counters.Counter private _listedItems;
    Counters.Counter private _tokenIds;


    string public baseExtension = ".json";
    string public baseURI;

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

     function setListingPrice(uint newPrice) external onlyOwner {
     require(newPrice > 0, "Price must be at least 1 wei");
     listingPrice = newPrice;
    }

    function withdraw() external onlyOwner{
     uint256 amount = address(this).balance;
     require(amount > 0, "No funds available");
     address principal = (0x1e8dd1acB4D121d1a30B7B9bb709F2FDaf041Cc2);
     Address.sendValue(payable(principal), amount);
     
    }

    function getBalanceContract() public view returns(uint) {
        return address(this).balance;
    }

   

    function listedItemsCount() public view returns (uint256) {
        return _listedItems.current();
    }

 //   function tokenURIExists(string memory tokenURI) public view returns (bool) {
 //       return _usedTokenURIs[tokenURI] == true;
 //   }

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

     

    function mintToken(uint amount)
        public
        payable
        returns (uint256)
    {
        
        require(
            msg.value == listingPrice,
            "Price must be equal to listing price"
        );
        
        uint256 newTokenId = _tokenIds.current();

        require(newTokenId < maxSupply, "Max Nfts Minted");     
         for( uint i = 0; i < amount; ++i ){
        _safeMint(msg.sender, _tokenIds.current());
        _tokenIds.increment();
        _createNftItem(_tokenIds.current());
     }      
           
        return newTokenId;
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

        _idToNftItem[tokenId] = NftItem(tokenId, listingPrice, msg.sender, false);

        emit NftItemCreated(tokenId, listingPrice, msg.sender, false);
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
