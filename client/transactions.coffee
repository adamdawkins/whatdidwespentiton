Template['transactions'].rendered = ->
  Session.set 'selected_transaction_ids', []

Template['transaction_row'].rendered = ->
  $('.ui.checkbox').checkbox()

Template['transaction_row'].events
  'change input[type="checkbox"]': (event, transaction) ->
    $checkbox = $(event.target)
    selected_transaction_ids = Session.get 'selected_transaction_ids'
    console.log @_id
    console.log selected_transaction_ids.push(@_id)

    if $checkbox.prop 'checked'
      Session.set 'selected_transaction_ids', selected_transaction_ids.push(@_id)
    else
      Session.set 'selected_transaction_ids', _.without(selected_transaction_ids, @_id)

    console.log "selected_transaction_ids: #{Session.get 'selected_transaction_ids'}"

