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
  transactions: ->
    TransactionSearch.getData(
      transform: (match_text, reg_exp) ->
        return match_text.replace(reg_exp, "<b>$&</b>")
      sort: date: -1
    )
  is_loading: ->
    return TransactionSearch.getStatus().loading
      

Template['transactions'].events
  'keyup #search_box': _.throttle(((event) ->
    text = $(event.target).val().trim()
    console.log "searching: #{text}"
    TransactionSearch.search text
    return
  ), 200)

  'click #select_all_button': (event, template) ->
    event.preventDefault()
    template.$(':checkbox').prop('checked', true).change() 
  'click #deselect_all_button': (event, template) ->
    event.preventDefault()
    template.$(':checkbox').prop('checked', false).change()


Template['transaction_row'].rendered = ->
  $('.ui.checkbox').checkbox()

Template['transaction_row'].helpers
  amount: ->
    accounting.formatMoney(@money.getAmount(), "£")

  short_date: ->
    moment(@date).format('DD/MM/YY')

Template['transaction_row'].events
  'change input[type="checkbox"]': (event, transaction) ->
    console.log "CHANGE"
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
