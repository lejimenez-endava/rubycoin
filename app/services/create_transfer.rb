class CreateTransfer
  def call(node, payee_port, amount)
    payee = JSON.parse Rubycoin::Client.fetch_public_information(payee_port)
    transaction = Core::Transaction.new(node.public_key, payee['public_key'], amount.to_i, node.private_key)
    node.blockchain.add_to_chain transaction
    [
      true,
      { message: 'transfer done!', amount: amount }
    ]
  rescue StandardError => e
    [
      false,
      { error: e, message: 'failed!' }
    ]
  end
end
