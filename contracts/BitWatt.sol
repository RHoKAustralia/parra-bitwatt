contract BitWatt {
	
	uint supply;
	mapping(address=> uint) bitwatts;
	mapping(address=> Member) member;

	struct Member {
		bool isMember;
	    bool isCurator;
	    bool exists;
	}

	modifier onlyMember {
	    if (!member[msg.sender].isMember) {
	      throw;
	    }
	    _
	}

	modifier onlyCurator {
	    if (!member[msg.sender].isCurator) {
	      throw;
	    }
	    _
	}

	function BitWatt() {
		member[msg.sender] = Member(true, true, true);
	}

	function totalSupply() constant returns (uint256 supply){
		return supply;
	}

	function balanceOf(address _owner) constant returns (uint256 balance){
		return bitwatts[_owner];
	}

	function transfer(address _to, uint256 _value) returns (bool success){
		if(bitwatts[msg.sender] >= _value){
			bitwatts[msg.sender] -= _value;
			bitwatts[_to] += _value;
			return true;
		}
		return false;
	}

	function issueBitwatts(uint256 _amount) onlyMember returns (bool success){
		bitwatts[msg.sender] += _amount;
		supply += _amount;
		return true;
	}

	function addCurator(address _nominee) onlyCurator returns (bool success){
		if(member[_nominee].exists){
			member[_nominee].isCurator = true;
			return true;
		}
		return false;
	}

	function addNewMember(address _nominee) onlyCurator returns (bool success){
		if(!member[_nominee].exists){
			member[_nominee] = Member(true, false, true);
			return true;
		}
		return false;
	}
}