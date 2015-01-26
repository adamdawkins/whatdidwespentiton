class @Account extends Minimongoid
  @_collection: new Meteor.Collection 'accounts'

  @has_many: [
    {
      name: 'transactions'
      foreign_key: 'account_id' 
    }
  ]

  @defaults:
    name: ''


  balances: ->
    Balance.where(
      account_id: @_id
    ,
      $sort:
        date: 1
    )
