Router.route('accounts/:_id',
  name: 'account.show'
  data: ->
    account: Account.first(@params._id)
    balances: Balance.where(
      account_id: @params._id
    )
)

Router.route('accounts/:_id/transactions',
  name: 'transactions'
  data: ->
    transactions = Transaction.where(
      account_id: @params._id
    )

    account: Account.first(@params._id)
    transactions: transactions
)
