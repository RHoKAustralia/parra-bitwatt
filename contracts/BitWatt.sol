/// @title A smart contract for accounting solar power generation

contract BitWatt {
	
	uint supply;
	mapping(address=> uint) bitwatts;
	mapping(address=> Member) public member;

	struct Member {
		bool isMember;
	    bool isCurator;
	    bool exists;
	}

	// event NewMember();
	// event NewCurator();
	// event BitwattIssued();
	// event BitwattRedeemed();

	modifier onlyMember {
	    if (member[msg.sender].isMember) {
	      _
	    }
	}

	modifier onlyCurator {
	    if (member[msg.sender].isCurator) {
	      _
	    }
	}

	// constructor - set contract creator as curator
	function BitWatt() {
		member[msg.sender] = Member(true, true, true);
	}

	/// @notice Get the total supply of bitwatts
	/// @return supply how many bitwatts are in circulation
	function totalSupply() constant returns (uint256 supply){
		return supply;
	}

	/// @notice get the bitwatt balance of an address
	/// @param _owner whose account we are checking
	/// @return balance how many bitwatts the _owner has
	function balanceOf(address _owner) constant returns (uint256 balance){
		return bitwatts[_owner];
	}

	/// @notice transfer bitwatts between accounts
	/// @param _to who the transfer is to
	/// @param _value how many bitwatts to transfer
	/// @return success if the transfer is made
	function transfer(address _to, uint256 _value) returns (bool success){
		if(bitwatts[msg.sender] >= _value){
			bitwatts[msg.sender] -= _value;
			bitwatts[_to] += _value;
			return true;
		}
		return false;
	}

	/// @notice issue bitwatts to a member
	/// @param _amount how many bitwatts to issue
	/// @return success if the bitwatts are issued
	function issueBitwatts(uint256 _amount) onlyMember returns (bool success){
		bitwatts[msg.sender] += _amount;
		supply += _amount;
		return true;
	}

	/// @notice curator can redeem bitwatts
	/// @param _amount how many bitwatts to redeem
	/// @return success if the bitwatts are redeemed
	function redeemBitwatts(uint256 _amount) onlyCurator returns (bool success){
		if(bitwatts[msg.sender] >= _amount){
			bitwatts[msg.sender] -= _amount;
			supply -= _amount;
			return true;
		}
		return false;
	}

	/// @notice set member status (only curators can call)
	/// @param _nominee which member status to set
	/// @param _member if they are a member or not
	/// @param _curator if they are a curator or not
	/// @return success if the status is set
	function setMemberStatus(address _nominee, bool _member, bool _curator) 
	onlyCurator returns(bool success) {
		if(member[_nominee].exists){
			member[_nominee].isCurator = _curator;
			member[_nominee].isMember = _member;
			return true;
		} else {
			member[_nominee] = Member(_member, _curator, true);
		}
	}

}