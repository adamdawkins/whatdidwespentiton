class @Transaction extends Minimongoid
  @_collection: new Meteor.Collection 'transactions'
  
  @before_create: (transaction) ->
    transaction.money = new Money(transaction.amount, 'GBP')
    transaction = _.omit(transaction, 'amount')

  validate: ->
   unless @account_id
     @error 'account_id', 'Transaction must belong to an account'
   unless @money
     @error 'money', 'Transaction needs a money object'
   unless @date
     @error 'date', 'Transaction needs a date'

  amount: ->
    return accounting.formatMoney(@money.getAmount(), "£")

  value: ->
    return @money.getAmount()

  short_date: ->
    moment(@date).format('DD/MM/YY')
