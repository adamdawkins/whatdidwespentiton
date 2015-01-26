Meteor.methods 
  'process_csv_statement': (csv, account_id) ->
    check csv, String
    check account_id, String
    parsed_csv = Baby.parse csv,
      header: true
      dynamicTying: true
    if parsed_csv.errors.length > 0
      throw new Meteor.Error 500, "something went wrong with the csv"
      console.log "CSV ERRORS:"
      console.log parsed_csv.errors
    else
      for row in parsed_csv.data
        unless row['Description'] is 'Balance carried forward'
          if row['Balance (£)'].length > 0
            Balance.create
              date: new Date(row['Date'])
              amount: row['Balance (£)']
              account_id: account_id

          amount = if row['Paid in'].length > 0 then row['Paid in'] else (row['Paid out']*-1)
          console.log "amount #{amount}"
          transaction =
            date: new Date(row['Date'])
            description: row['Description']
            amount: amount 
            account_id: account_id

          console.log transaction
          Transaction.create(transaction)

      return parsed_csv.data
