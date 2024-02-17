//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {BasicNft} from "../../src/BasicNft.sol";
import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public s_deployer;
    BasicNft public s_basicNft;
    address public i_user = makeAddr("Alice");
    string public constant PUG =
        "https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8?filename=pug.png";

    function setUp() public {
        s_deployer = new DeployBasicNft();
        s_basicNft = s_deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Nature";
        string memory actualName = s_basicNft.name();

        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(i_user);
        s_basicNft.mintNft(PUG);

        assert(s_basicNft.balanceOf(i_user) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(s_basicNft.tokenURI(0)))
        );
    }
}
