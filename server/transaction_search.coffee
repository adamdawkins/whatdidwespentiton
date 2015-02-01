SearchSource.defineSource 'transactions', (search_text, options) ->
  options = sort: date: -1

  if search_text
    selector = description: new RegExp(search_text.trim(), 'ig')

    Transaction.find(selector, options)
  else
    Transaction.find({}, options).fetch()
