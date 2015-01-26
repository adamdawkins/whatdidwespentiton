Meteor.startup ->
  if Account.count() is 0
    Account.create
      name: "Joint Account"
