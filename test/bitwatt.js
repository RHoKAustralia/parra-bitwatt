contract('BittWatt', function(accounts) {
  
  it("should set contract creator as a curator", function(done) {
    var bitwatt = BitWatt.deployed();
    bitwatt.member.call(accounts[0]).then(function(result) {
      assert.equal(result[2], true, 'creator not set as curator on instatiation');
    }).then(done).catch(done);
  });

  it("should set contract creator as a member", function(done) {
    var bitwatt = BitWatt.deployed();
    bitwatt.member.call(accounts[0]).then(function(result) {
      assert.equal(result[1], true, 'creator not set as member on instatiation');
    }).then(done).catch(done);
  });

  it("should set contract creator as exists", function(done) {
    var bitwatt = BitWatt.deployed();
    bitwatt.member.call(accounts[0]).then(function(result) {
      assert.equal(result[0], true, 'creator not set as exists on instatiation');
    }).then(done).catch(done);
  });

  it("should be able to issue bitwatts", function(done) {
    var bitwatt = BitWatt.deployed();
    bitwatt.issueBitwatts(100, {from:accounts[0]}).then(function(result) {
      return bitwatt.balanceOf.call(accounts[0]);
    }).then(function(balance) {
      assert.equal(balance, 100, '100 bitwatts not issued');
      return bitwatt.totalSupply.call();    
    }).then(function(supply) {
      assert.equal(supply.toNumber(), 100, 'supply not set to 100');
    }).then(done).catch(done);
  });

  it("should be able to redeem bitwatts", function(done) {
    var bitwatt = BitWatt.deployed();
    bitwatt.redeemBitwatts(100, {from:accounts[0]}).then(function(result) {
      return bitwatt.balanceOf.call(accounts[0]);
    }).then(function(balance) {
      assert.equal(balance, 0, '100 bitwatts not redeemed');
      return bitwatt.totalSupply.call();    
    }).then(function(supply) {
      assert.equal(supply.toNumber(), 0, 'supply not set to 0');
    }).then(done).catch(done);
  });

  it("should be able to set a new member", function(done) {
    var bitwatt = BitWatt.deployed();
    bitwatt.setMemberStatus(accounts[1], true, false, {from: accounts[0]}).then(function(result) {
      return bitwatt.member.call(accounts[1]);
    }).then(function(result) {
      assert.equal(result[0], true, 'new member not added');
    }).then(done).catch(done);
  });

  it("should be able to transfer bitwatts", function(done) {
    var bitwatt = BitWatt.deployed();
    bitwatt.issueBitwatts(100, {from:accounts[0]}).then(function(result) {
      return bitwatt.balanceOf.call(accounts[0]);
    }).then(function(balance) {
      assert.equal(balance, 100, '100 bitwatts not issued');
      return bitwatt.transfer(accounts[1], 100, {from: accounts[0]});    
    }).then(function() {
      return bitwatt.balanceOf.call(accounts[1]);
    }).then(function(balance) {
      assert.equal(balance, 100, '100 bitwatts not transferred');
    }).then(done).catch(done);
  });

});
