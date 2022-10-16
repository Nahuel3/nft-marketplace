// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NftMarketAquans is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;
    using Address for address;

    struct NftItem {
        uint256 tokenId;
        uint256 price;
        address creator;
        bool isListed;
    }

    struct GroupNft {
        uint64 listingPrice;
        uint16 startTokenId;
        uint16 endTokenId;
    }

    GroupNft[] public AllTokens;

    Counters.Counter private _listedItems;
    Counters.Counter private _tokenIds;

    string private baseExtension = ".json";
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

    constructor() ERC721("SCCNFT", "SNcFT") {
 
        //FOXYS DEJAR ESPACIO DE 10K DE NFTS POR EJEMPLO 0, 10000  .    20000, 40000
        AllTokens.push(GroupNft(0.0025 ether, 0, 8));   //MYSTIC

        AllTokens.push(GroupNft(0.0035 ether, 16, 32)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 48, 72));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 90, 108));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 122, 148));  //EPIC

        AllTokens.push(GroupNft(1 ether, 172, 200));  //IMMORTAL

        //FOXYS WOMAN
        
        AllTokens.push(GroupNft(0.25 ether, 220, 240));   //MYSTIC

        AllTokens.push(GroupNft(0.35 ether, 280, 320)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 360, 400));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 440, 480));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 520, 580));  //EPIC

        AllTokens.push(GroupNft(1 ether, 640, 720));  //IMMORTAL

        //ALUFI
        AllTokens.push(GroupNft(0.25 ether, 780, 840));   //MYSTIC

        AllTokens.push(GroupNft(0.35 ether, 890, 932)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 970, 1000));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 1030, 1080));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 1120, 1180));  //EPIC

        AllTokens.push(GroupNft(1 ether, 1250, 1300));  //IMMORTAL

        //ALUFI WOMAN
       AllTokens.push(GroupNft(0.25 ether, 1350, 1400));   //MYSTIC

        AllTokens.push(GroupNft(0.35 ether, 1450, 1500)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 1560, 1620));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 1685, 1725));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 1760, 1790));  //EPIC

        AllTokens.push(GroupNft(1 ether, 1850, 1920));  //IMMORTAL

        //FLUFFLY

        AllTokens.push(GroupNft(0.25 ether, 1950, 2000));   //MYSTIC

        AllTokens.push(GroupNft(0.35 ether, 2025, 2070)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 2110, 2170));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 2250, 2290));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 2340, 2400));  //EPIC

        AllTokens.push(GroupNft(1 ether, 2480, 2520));  //IMMORTAL

        //FLUFFLY WOMAN
        AllTokens.push(GroupNft(0.25 ether, 2580, 2650));   //MYSTIC

        AllTokens.push(GroupNft(0.35 ether, 2700, 2780)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 2850, 2900));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 3000, 3100));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 3200, 3300));  //EPIC

        AllTokens.push(GroupNft(1 ether, 3400, 3500));  //IMMORTAL


        //ELFS 
        
        AllTokens.push(GroupNft(0.25 ether, 3600, 3800));   //MYSTIC

        AllTokens.push(GroupNft(0.35 ether, 3900, 4200)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 4300, 4350));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 4380, 4420));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 4490, 4530));  //EPIC

        AllTokens.push(GroupNft(1 ether, 4700, 4900));  //IMMORTAL

        //ELFS WOMAN
        AllTokens.push(GroupNft(0.25 ether, 5000, 5100));   //MYSTIC

        AllTokens.push(GroupNft(0.35 ether, 5300, 5325)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 5400, 5700));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 5900, 6100));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 6400, 6700));  //EPIC

        AllTokens.push(GroupNft(1 ether, 6900, 7000));  //IMMORTAL

        //GOLEMS 
        AllTokens.push(GroupNft(0.25 ether, 7200, 7300));   //MYSTIC

        AllTokens.push(GroupNft(0.35 ether, 7400, 7500)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 7600, 7700));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 7800, 7900));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 8200, 8400));  //EPIC

        AllTokens.push(GroupNft(1 ether, 8600, 8800));  //IMMORTAL

        //GOLEMS WOMAN

        AllTokens.push(GroupNft(0.25 ether, 9000, 9200));   //MYSTIC

        AllTokens.push(GroupNft(0.35 ether, 9400, 9630)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 9800, 9900));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 10200, 11000));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 11250, 11500));  //EPIC

        AllTokens.push(GroupNft(1 ether, 12000, 13000));  //IMMORTAL

        //AQUANS WOMAN
        AllTokens.push(GroupNft(0.25 ether, 14000, 14500));   //MYSTIC

        AllTokens.push(GroupNft(0.35 ether, 14700, 15000)); //MAGIC

        AllTokens.push(GroupNft(0.45 ether, 15500, 16000));  //GLORIOUS

        AllTokens.push(GroupNft(0.65 ether, 16500, 17000));  //LEGENDARY

        AllTokens.push(GroupNft(0.85 ether, 17500, 18000));  //EPIC

        AllTokens.push(GroupNft(1 ether, 20000, 22500));  //IMMORTAL

        
    }

    function setMaxNfts(uint16 newMaxEndTokenId, uint256 tokenType) external onlyOwner {
        GroupNft storage group = AllTokens[tokenType];
        require(
            newMaxEndTokenId > group.endTokenId,
            "the amount of nft must be greater than the existing one"
        );

        group.endTokenId = newMaxEndTokenId;
        
    }

    function withdraw() external onlyOwner {
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

     function buyNfts(uint256 tokenType, uint8 amount)
        public
        payable
        returns (uint256)
    {
        GroupNft storage group = AllTokens[tokenType];

        require(
            msg.value == group.listingPrice * amount,
            "Price must be equal to listing price"
        );
 
        require(
            group.startTokenId + amount <= group.endTokenId,
            "Nft minted is max"
            );

        require(amount > 0, "Invalid amount");

        uint256 startTokenId = group.startTokenId; //temps variable     hat contains the start value
        group.startTokenId += amount; //Update the state - this won't change startTokenId temps variable

        for (uint256 i = 0; i < amount; ++i) {
        _safeMint(msg.sender, startTokenId + i);
        _createNftItem(startTokenId + i, tokenType);           
        }

        return group.startTokenId;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(_exists(tokenId));

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

    function cancellSellNft(uint256 tokenId) public {
        require(
            ERC721.ownerOf(tokenId) == msg.sender,
            "You are not owner of this nft"
        );

        _idToNftItem[tokenId].isListed = false;
        _listedItems.decrement();
    }

    function placeNftOnSale(uint256 tokenId, uint256 newPrice) public payable {
        require(
            ERC721.ownerOf(tokenId) == msg.sender,
            "You are not owner of this nft"
        );
        require(
            _idToNftItem[tokenId].isListed == false,
            "Item is already on sale"
        );

        _idToNftItem[tokenId].isListed = true;
        _idToNftItem[tokenId].price = newPrice;
        _listedItems.increment();
    }

    function _createNftItem(uint256 tokenId, uint256 tokenType) private {
        _idToNftItem[tokenId] = NftItem(
            tokenId,
            AllTokens[tokenType].listingPrice,
            msg.sender,
            false
        );

        emit NftItemCreated(
            tokenId,
            AllTokens[tokenType].listingPrice,
            msg.sender,
            false
        );
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

    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        uint256 lastTokenIndex = _allNfts.length - 1;
        uint256 tokenIndex = _idToNftIndex[tokenId];
        uint256 lastTokenId = _allNfts[lastTokenIndex];

        _allNfts[tokenIndex] = lastTokenId;
        _idToNftIndex[lastTokenId] = tokenIndex;

        delete _idToNftIndex[tokenId];
        _allNfts.pop();
    }
}
