options = 
  keepHistory: 1000 * 60 * 5
  localSearch: true

fields = ['description']

@TransactionSearch = new SearchSource('transactions', fields, options)
