Template['transactions'].rendered = ->
  @$('.ui.sticky').sticky(
    context: '#transactions_content'
  )
  Session.set 'selected_transaction_ids', []
  Session.set 'selected_transactions_count', 0

Template['transactions'].helpers
  selected_transactions_count: ->
    Session.get 'selected_transactions_count'
  selected_transaction_ids: ->
    Session.get 'selected_transaction_ids'

Template['transaction_row'].rendered = ->
  $('.ui.checkbox').checkbox()

Template['transaction_row'].events
  'change input[type="checkbox"]': (event, transaction) ->
    $checkbox = $(event.target)
    selected_transaction_ids = Session.get 'selected_transaction_ids'
    
    if $checkbox.prop 'checked'
      selected_transaction_ids.push @_id
      selected_transactions_count = Session.get('selected_transactions_count') + 1
      Session.set 'selected_transaction_ids', selected_transaction_ids
    else
      selected_transactions_count = Session.get('selected_transactions_count') - 1
      Session.set 'selected_transaction_ids', _.without(selected_transaction_ids, @_id)

    Session.set 'selected_transactions_count', selected_transactions_count
