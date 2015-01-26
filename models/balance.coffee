class @Balance extends Minimongoid
  @_collection: new Meteor.Collection 'balances'

  @before_create: (balance) ->
    balance.money = new Money(balance.amount, 'GBP')
    balance = _.omit(balance, 'amount')

  validate: ->
   unless @account_id
     @error 'account_id', 'Balance must belong to an account'
   unless @money
     @error 'money', 'Balance needs a money object'
   unless @date
     @error 'date', 'Balance needs a date'

  amount: ->
    return accounting.formatMoney(@money.getAmount(), "£")

  value: ->
    return @money.getAmount()

  account: ->
    return Account.first(
      _id: @account_id
    )
