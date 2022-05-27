require 'rails_helper'

RSpec.describe Core::Transaction do
  describe "when is a genesis transaction" do
    let(:genesis_txn) { Core::Transaction.new nil, 1234, 400, 2344 }

    it "has a valid signature" do
      expect(genesis_txn.is_valid_signature?).to eq true
    end

    it "does not have an origin sender money" do
      expect(genesis_txn.genesis_txn?).to eq true
    end

    it "has a message" do
      expect(genesis_txn.message).to eq "9aff81d6b5b7a48c135f9ca069fc3c6134b2469c0d154cee68ee47e4443d705b"
    end
  end

  describe "when is a typical transaction" do
    let(:transaction){ Core::Transaction.new 6789, 1234, 400, 2344}

    it "is not a genesis transaction" do
      expect(transaction.genesis_txn?).to eq false
    end

    it "has a valid signature" do
      allow(Rubycoin::PKI).to receive(:valid_signature?).and_return(true)
      expect(transaction.is_valid_signature?).to eq true
    end

    it "can have an invalid signature" do
      allow(Rubycoin::PKI).to receive(:valid_signature?).and_return(false)
      expect(transaction.is_valid_signature?).to eq false
    end

    it "has a message" do
      expect(transaction.message).to eq "045ed4ad1bde9ed51c110f4de739e70eddbdaa486229f0e33ff8eb7e6b329336"
    end
  end
end
