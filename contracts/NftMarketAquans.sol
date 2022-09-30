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

    struct GruopNft {
        uint64 listingPrice;
        uint16 startTokenId;
        uint16 endTokenId;
    }

    GruopNft[] public AllTokens;

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
        AllTokens.push(GruopNft(0.25 ether, 0, 8));

        AllTokens.push(GruopNft(0.35 ether, 8, 16));

        AllTokens.push(GruopNft(0.45 ether, 16, 32));
    }

    function setMaxNfts(uint16 newMax, uint256 tokenId) external onlyOwner {
        require(
            newMax > AllTokens[tokenId].endTokenId,
            "the amount of nft must be greater than the existing one"
        );
        AllTokens[tokenId].endTokenId = newMax;
    }

    //    function setMaxAquansMagico(uint newMaxAquan) external onlyOwner {
    //     require(newMaxAquan > maxAquanMagico, "the amount of Aquans must be greater than the existing one");
    //     maxAquanMagico = newMaxAquan;
    //    }

    ///    function setMaxAquansGlorioso(uint newMaxAquan) external onlyOwner {
    //     require(newMaxAquan > maxAquanGlorioso, "the amount of Aquans must be greater than the existing one");
    //     maxAquanGlorioso = newMaxAquan;
    //   }

    //   function setMaxAquansLegendario(uint newMaxAquan) external onlyOwner {
    //    require(newMaxAquan > maxAquanLegendario, "the amount of Aquans must be greater than the existing one");
    //   maxAquanLegendario = newMaxAquan;
    //   }

    //  function setMaxAquansEpico(uint newMaxAquan) external onlyOwner {
    //   require(newMaxAquan > maxAquanEpico, "the amount of Aquans must be greater than the existing one");
    //    maxAquanEpico = newMaxAquan;
    //   }

    //    function setMaxAquansInmortal(uint newMaxAquan) external onlyOwner {
    //        require(newMaxAquan > maxAquanInmortal, "the amount of Aquans must be greater than the existing one");
    //        maxAquanInmortal = newMaxAquan;
    //       }

    //        function setMaxAquansMisticoWoman(uint newMaxAquan) external onlyOwner {
    //        require(newMaxAquan > maxAquanMisticoWoman, "the amount of AquansWoman must be greater than the existing one");
    //        maxAquanMisticoWoman = newMaxAquan;
    //       }

    //       function setMaxAquansMagicoWoman(uint newMaxAquan) external onlyOwner {
    //         require(newMaxAquan > maxAquanMagicoWoman, "the amount of AquansWoman must be greater than the existing one");
    //         maxAquanMagicoWoman = newMaxAquan;
    //        }

    //       function setMaxAquansGloriosoWoman(uint newMaxAquan) external onlyOwner {
    //        require(newMaxAquan > maxAquanGloriosoWoman, "the amount of AquansWoman must be greater than the existing one");
    //         maxAquanGloriosoWoman = newMaxAquan;
    //        }

    //       function setMaxAquansLegendarioWoman(uint newMaxAquan) external onlyOwner {
    //        require(newMaxAquan > maxAquanLegendarioWoman, "the amount of AquansWoman must be greater than the existing one");
    //        maxAquanLegendarioWoman = newMaxAquan;
    //        }

    //       function setMaxAquansEpicoWoman(uint newMaxAquan) external onlyOwner {
    //         require(newMaxAquan > maxAquanEpicoWoman, "the amount of AquansWoman must be greater than the existing one");
    //         maxAquanEpicoWoman = newMaxAquan;
    //        }

    //       function setMaxAquansInmortalWoman(uint newMaxAquan) external onlyOwner {
    //        require(newMaxAquan > maxAquanInmortalWoman, "the amount of AquansWoman must be greater than the existing one");
    //        maxAquanInmortalWoman = newMaxAquan;
    //       }

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

    function AquansBuy(uint256 tokenType, uint8 amount)
        public
        payable
        returns (uint256)
    {
        GruopNft storage group = AllTokens[tokenType];

        require(
            msg.value == group.listingPrice * amount,
            "Price must be equal to listing price"
        );
 
        require(
            group.startTokenId + amount <= group.endTokenId,
            "Nft minted is max"
            );

        for (uint256 i = 0; i < amount; ++i) {
            _safeMint(msg.sender, group.startTokenId);
            _createNftItem(group.startTokenId);
        }
        group.startTokenId += amount;

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

    function _createNftItem(uint256 tokenId) private {
        _idToNftItem[tokenId] = NftItem(
            tokenId,
            AllTokens[tokenId].listingPrice,
            msg.sender,
            false
        );

        emit NftItemCreated(
            tokenId,
            AllTokens[tokenId].listingPrice,
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
