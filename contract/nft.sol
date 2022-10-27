// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/Strings.sol"; 



contract MyToken is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 public mintRate = 0.00000 ether;
    uint256 public nftPerAddressLimit = 5;
    uint256 public MAX_SUPPLY = 10000;
    address[] public whitelistedAddresses;
    string baseURI  = "ipfs://QmaxAQWSyoDCiYu21LeeGocAr7SRAzbgUeW7oYSwcki94k/";
    string public baseExtension = ".json";
    mapping(uint256 => string) private _tokenURIs;
    bool public onlyWhitelisted = true;

    constructor()ERC721("Data_Boy", "DB") {
        
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }
        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return
            string(abi.encodePacked(base, Strings.toString(tokenId), baseExtension));
    }

    function safeMint() public payable{
        uint256 ownerTokenCount = balanceOf(msg.sender);
        uint256 tokenId = _tokenIdCounter.current();
        require(totalSupply() < MAX_SUPPLY, "Can't mint more!!");
        require(msg.value >= mintRate, "Not enough ether send!!!");
        require(isWhitelisted(msg.sender), "user is not whitelisted!!");
        require(ownerTokenCount < nftPerAddressLimit, "Can't mint more!!");
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function isWhitelisted(address _user) public view returns(bool){
        for(uint256 i = 0; i < whitelistedAddresses.length; i++){
            if(whitelistedAddresses[i] == _user){
                return true;
            }
        }
        return false;
    }

    function whitelistUsers(address[] calldata _users) public onlyOwner{
        delete whitelistedAddresses;
        whitelistedAddresses = _users;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function withdraw() public onlyOwner{
        require(address(this).balance > 0, "Balance is 0!!!");
        payable(owner()).transfer(address(this).balance);
    }
}