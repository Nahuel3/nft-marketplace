const instance = await NftMarket.deployed();

instance.mintToken("500000000000000000", {value: "25000000000000000",from: accounts[0]})
instance.mintToken("300000000000000000", {value: "25000000000000000",from: accounts[0]})