Template['account_csv_form'].events
  'submit form': (event, template) ->
    event.preventDefault()
    csv = template.$('textarea').val()
    Meteor.call 'process_csv_statement', csv, @_id, (error, result) ->
      if error
        toastr.error error, "Shit went wrong"
      else
        toastr.success "CSV processed"

