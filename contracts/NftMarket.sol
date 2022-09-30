// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

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

    struct GruopFoxy {
        uint64 listingPriceMistico;
        uint16 startTokenId;
        uint16 endTokenId;
        string razaNft;
    }

    GruopFoxy public foxyMistico = GruopFoxy(0.25 ether, 0, 8, "foxyMistico");
    GruopFoxy public foxyMisticoWoman =
        GruopFoxy(0.25 ether, 8, 15, "foxyMisticoWoman");

    GruopFoxy public foxyMagico = GruopFoxy(0.35 ether, 15, 23, "foxyMagico");
    GruopFoxy public foxyMagicoWoman =
        GruopFoxy(0.35 ether, 23, 31, "foxyMagicoWoman");

    GruopFoxy public foxyGlorioso =
        GruopFoxy(0.55 ether, 31, 39, "foxyGlorioso");
    GruopFoxy public foxyGloriosoWoman =
        GruopFoxy(0.55 ether, 39, 46, "foxyGloriosoWoman");

    GruopFoxy public foxyLegendario =
        GruopFoxy(0.75 ether, 46, 56, "foxyLegendario");
    GruopFoxy public foxyLegendarioWoman =
        GruopFoxy(0.75 ether, 56, 62, "foxyLegendarioWoman");

    GruopFoxy public foxyEpico = GruopFoxy(1 ether, 62, 71, "foxyEpico");
    GruopFoxy public foxyEpicoWoman =
        GruopFoxy(1 ether, 71, 79, "foxyEpicoWoman");

    GruopFoxy public foxyInmortal =
        GruopFoxy(1.25 ether, 79, 86, "foxyInmortal");
    GruopFoxy public foxyInmortalWoman =
        GruopFoxy(1.25 ether, 85, 93, "foxyInmortalWoman");

    Counters.Counter private _listedItems;
    Counters.Counter private _tokenIds;

    string private baseExtension = ".json";
    string public baseURI;

    mapping(string => bool) private _usedTokenURIs;
    mapping(uint256 => NftItem) public _idToNftItem;
    mapping(uint256 => GruopFoxy) public _GruopFoxy;

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

    constructor() ERC721("ElfNFT", "ENFT") {}

    function setMaxFoxysMistico(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyMistico.endTokenId,
            "the amount of foxys must be greater than the existing one"
        );
        foxyMistico.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysMagico(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyMagico.endTokenId,
            "the amount of foxys must be greater than the existing one"
        );
        foxyMagico.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysGlorioso(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyGlorioso.endTokenId,
            "the amount of foxys must be greater than the existing one"
        );
        foxyGlorioso.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysLegendario(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyLegendario.endTokenId,
            "the amount of foxys must be greater than the existing one"
        );
        foxyLegendario.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysEpico(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyEpico.endTokenId,
            "the amount of foxys must be greater than the existing one"
        );
        foxyEpico.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysInmortal(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyInmortal.endTokenId,
            "the amount of foxys must be greater than the existing one"
        );
        foxyInmortal.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysMisticoWoman(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyMisticoWoman.endTokenId,
            "the amount of foxysWoman must be greater than the existing one"
        );
        foxyMisticoWoman.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysMagicoWoman(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyMagicoWoman.endTokenId,
            "the amount of foxysWoman must be greater than the existing one"
        );
        foxyMagicoWoman.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysGloriosoWoman(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyGloriosoWoman.endTokenId,
            "the amount of foxysWoman must be greater than the existing one"
        );
        foxyGloriosoWoman.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysLegendarioWoman(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyInmortalWoman.endTokenId,
            "the amount of foxysWoman must be greater than the existing one"
        );
        foxyInmortalWoman.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysEpicoWoman(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyEpicoWoman.endTokenId,
            "the amount of foxysWoman must be greater than the existing one"
        );
        foxyEpicoWoman.endTokenId = newMaxFoxy;
    }

    function setMaxFoxysInmortalWoman(uint16 newMaxFoxy) external onlyOwner {
        require(
            newMaxFoxy > foxyInmortalWoman.endTokenId,
            "the amount of foxysWoman must be greater than the existing one"
        );
        foxyInmortalWoman.endTokenId = newMaxFoxy;
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

    function foxyBuyMistico(uint256 amount, string memory _raza)
        public
        payable
        returns (uint256 foxy)
    {
        require(
            msg.value == foxyMistico.listingPriceMistico,
            "Price must be equal to listing price"
        );

        bytes32 hash_raza = keccak256(abi.encodePacked(_raza));
        bytes32 hash_razaNft = keccak256(abi.encodePacked(foxyMistico.razaNft));
        bytes32 hash_razaNftWoman = keccak256(
            abi.encodePacked(foxyMisticoWoman.razaNft)
        );

        if (hash_raza == hash_razaNft) {
            require(
                foxyMistico.startTokenId < foxyMistico.endTokenId,
                "Max FoxyMistico Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyMistico.startTokenId);
                _createNftItem(foxyMistico.startTokenId);
                foxyMistico.startTokenId += 1;
            }

            return foxyMistico.startTokenId;
        } else if (hash_raza == hash_razaNftWoman) {
            require(
                foxyMisticoWoman.startTokenId < foxyMisticoWoman.endTokenId,
                "Max foxyMisticoWoman Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyMisticoWoman.startTokenId);
                _createNftItem(foxyMisticoWoman.startTokenId);
                foxyMisticoWoman.startTokenId += 1;
            }

            return foxyMisticoWoman.startTokenId;
        }
    }

    function foxyBuyMagico(uint256 amount, string memory _raza)
        public
        payable
        returns (uint256 foxy)
    {
        bytes32 hash_raza = keccak256(abi.encodePacked(_raza));
        bytes32 hash_razaNft = keccak256(abi.encodePacked(foxyMagico.razaNft));
        bytes32 hash_razaNftWoman = keccak256(
            abi.encodePacked(foxyMagicoWoman.razaNft)
        );

        if (hash_raza == hash_razaNft) {
            require(
                foxyMagico.startTokenId < foxyMagico.endTokenId,
                "Max FoxyMagico Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyMagico.startTokenId);
                _createNftItem(foxyMagico.startTokenId);
                foxyMagico.startTokenId += 1;
            }

            return foxyMagico.startTokenId;
        } else if (hash_raza == hash_razaNftWoman) {
            require(
                foxyMagicoWoman.startTokenId < foxyMagicoWoman.endTokenId,
                "Max foxyMisticoWoman Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyMagicoWoman.startTokenId);
                _createNftItem(foxyMagicoWoman.startTokenId);
                foxyMagicoWoman.startTokenId += 1;
            }

            return foxyMagicoWoman.startTokenId;
        }
    }

    function foxyBuyGlorioso(uint256 amount, string memory _raza)
        public
        payable
        returns (uint256 foxy)
    {
        bytes32 hash_raza = keccak256(abi.encodePacked(_raza));
        bytes32 hash_razaNft = keccak256(
            abi.encodePacked(foxyGlorioso.razaNft)
        );
        bytes32 hash_razaNftWoman = keccak256(
            abi.encodePacked(foxyGloriosoWoman.razaNft)
        );

        if (hash_raza == hash_razaNft) {
            require(
                foxyGlorioso.startTokenId < foxyGlorioso.endTokenId,
                "Max FoxyGlorioso Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyGlorioso.startTokenId);
                _createNftItem(foxyGlorioso.startTokenId);
                foxyGlorioso.startTokenId += 1;
            }

            return foxyGlorioso.startTokenId;
        } else if (hash_raza == hash_razaNftWoman) {
            require(
                foxyGloriosoWoman.startTokenId < foxyGloriosoWoman.endTokenId,
                "Max foxyMisticoWoman Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyGloriosoWoman.startTokenId);
                _createNftItem(foxyGloriosoWoman.startTokenId);
                foxyGloriosoWoman.startTokenId += 1;
            }

            return foxyGloriosoWoman.startTokenId;
        }
    }

    function foxyBuyLegendario(uint256 amount, string memory _raza)
        public
        payable
        returns (uint256 foxy)
    {
        bytes32 hash_raza = keccak256(abi.encodePacked(_raza));
        bytes32 hash_razaNft = keccak256(
            abi.encodePacked(foxyLegendario.razaNft)
        );
        bytes32 hash_razaNftWoman = keccak256(
            abi.encodePacked(foxyLegendarioWoman.razaNft)
        );

        if (hash_raza == hash_razaNft) {
            require(
                foxyLegendario.startTokenId < foxyLegendario.endTokenId,
                "Max FoxyLegendario Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyLegendario.startTokenId);
                _createNftItem(foxyLegendario.startTokenId);
                foxyLegendario.startTokenId += 1;
            }

            return foxyLegendario.startTokenId;
        } else if (hash_raza == hash_razaNftWoman) {
            require(
                foxyLegendarioWoman.startTokenId <
                    foxyLegendarioWoman.endTokenId,
                "Max foxyMisticoWoman Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyLegendarioWoman.startTokenId);
                _createNftItem(foxyLegendarioWoman.startTokenId);
                foxyLegendarioWoman.startTokenId += 1;
            }

            return foxyLegendarioWoman.startTokenId;
        }
    }

    function foxyBuyEpico(uint256 amount, string memory _raza)
        public
        payable
        returns (uint256 foxy)
    {
        bytes32 hash_raza = keccak256(abi.encodePacked(_raza));
        bytes32 hash_razaNft = keccak256(abi.encodePacked(foxyEpico.razaNft));
        bytes32 hash_razaNftWoman = keccak256(
            abi.encodePacked(foxyEpicoWoman.razaNft)
        );

        if (hash_raza == hash_razaNft) {
            require(
                foxyEpico.startTokenId < foxyEpico.endTokenId,
                "Max FoxyEpico Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyEpico.startTokenId);
                _createNftItem(foxyEpico.startTokenId);
                foxyEpico.startTokenId += 1;
            }

            return foxyEpico.startTokenId;
        } else if (hash_raza == hash_razaNftWoman) {
            require(
                foxyEpicoWoman.startTokenId < foxyEpicoWoman.endTokenId,
                "Max foxyMisticoWoman Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyEpicoWoman.startTokenId);
                _createNftItem(foxyEpicoWoman.startTokenId);
                foxyEpicoWoman.startTokenId += 1;
            }

            return foxyEpicoWoman.startTokenId;
        }
    }

    function FoxyBuyInmortal(uint256 amount, string memory _raza)
        public
        payable
        returns (uint256 foxy)
    {
        bytes32 hash_raza = keccak256(abi.encodePacked(_raza));
        bytes32 hash_razaNft = keccak256(
            abi.encodePacked(foxyInmortal.razaNft)
        );
        bytes32 hash_razaNftWoman = keccak256(
            abi.encodePacked(foxyInmortalWoman.razaNft)
        );

        if (hash_raza == hash_razaNft) {
            require(
                foxyInmortal.startTokenId < foxyInmortal.endTokenId,
                "Max FoxyInmortal Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyInmortal.startTokenId);
                _createNftItem(foxyInmortal.startTokenId);
                foxyInmortal.startTokenId += 1;
            }

            return foxyInmortal.startTokenId;
        } else if (hash_raza == hash_razaNftWoman) {
            require(
                foxyInmortalWoman.startTokenId < foxyInmortalWoman.endTokenId,
                "Max foxyMisticoWoman Nfts Minted"
            );
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, foxyInmortalWoman.startTokenId);
                _createNftItem(foxyInmortalWoman.startTokenId);
                foxyInmortalWoman.startTokenId += 1;
            }

            return foxyInmortalWoman.startTokenId;
        }
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
            foxyMistico.listingPriceMistico,
            msg.sender,
            false
        );

        emit NftItemCreated(
            tokenId,
            foxyMistico.listingPriceMistico,
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
