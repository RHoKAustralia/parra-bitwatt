contract('BittWatt', function(accounts) {
  
  it("should set contract creator as a curator", function(done) {
    var bitwatt = BitWatt.deployed();
    bitwatt.member.call(accounts[0]).then(function(result) {
      assert.equal(result[2], true, 'creator not set as curator on instatiation');
    }).then(done).catch(done);
  });

});
