// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Note     : Interactive on-chain metadata for Hikari Riders

import "@openzeppelin/contracts/utils/Base64.sol";
//import "@openzeppelin/contracts/utils/Strings.sol";


contract OnchainData { 

    function fetchMetadata (uint256 _tokenID) external pure returns (string memory) {

        string memory _name = "Hikari Riot Pass #";
        string memory _desc = "Hikari Riot Pass is a membership pass by Hikari Riders backed by NFT technology. This pass will grant the holder access to perks within the Hikari Riders ecosystem.";
        string memory _image = "http://arweave.net/PPhGPCcE445tddFMZYzXNIU_Rl-wbz0Gc_PZ76waNuY";
        string memory _animURL = "http://arweave.net/BfJC-XcqUalYqEkQcOh0cSD6DCNKXu9qBmYktPQUpU8";

        string[5] memory attr;

        attr[0] = '{"trait_type":"ID","value":"';
        attr[1] = toString(_tokenID);
        attr[2] = '"},{"trait_type":"Supply","value":"2500"},';
        attr[3] = '{"trait_type":"Type","value":"Pass"},';
        attr[4] = '{"trait_type":"Point","value":"0"}';

        string memory _attr = string(
            abi.encodePacked(attr[0], attr[1], attr[2], attr[3], attr[4])
        );

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        _name, toString(_tokenID),
                        '", "description": "',
                        _desc,
                        '", "image": "',
                        _image, '", "animation_url": "', _animURL, '", "attributes": [',
                        _attr,
                        "]",
                        "}"
                    )
                )
            )
        );
        string memory output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        return output;
    }

    function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT license
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}