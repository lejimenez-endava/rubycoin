require 'rails_helper'

RSpec.describe Core::Transaction do
  describe "when is a genesis transaction" do
    it "has a valid signature" do
      genesis_txn = Core::Transaction.new nil, 1234, 400, 2344
      expect(genesis_txn.is_valid_signature?).to eq true
    end

    it "does not have an origin sender money" do
      transaction = Core::Transaction.new nil, 1234, 400, 2344
      expect(transaction.genesis_txn?).to eq true
    end

    it "has a message" do
      transaction = Core::Transaction.new 6789, 1234, 400, 2344
      expect(transaction.message).to eq "045ed4ad1bde9ed51c110f4de739e70eddbdaa486229f0e33ff8eb7e6b329336"
    end
  end

  describe "when is a typical transaction" do
    it "is not a genesis transaction" do
      transaction = Core::Transaction.new 6789, 1234, 400, 2344
      expect(transaction.genesis_txn?).to eq false
    end

    it "has a valid signature" do
      allow(Rubycoin::PKI).to receive(:valid_signature?).and_return(true)
      transaction = Core::Transaction.new 6789, 1234, 400, 2344
      expect(transaction.is_valid_signature?).to eq true
    end

    it "can have an invalid signature" do
      allow(Rubycoin::PKI).to receive(:valid_signature?).and_return(false)
      transaction = Core::Transaction.new 6789, 1234, 400, 2344
      expect(transaction.is_valid_signature?).to eq false
    end

    it "has a message" do
      transaction = Core::Transaction.new 6789, 1234, 400, 2344
      expect(transaction.message).to eq "045ed4ad1bde9ed51c110f4de739e70eddbdaa486229f0e33ff8eb7e6b329336"
    end
  end
end
