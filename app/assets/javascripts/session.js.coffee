###
## functions processing the login page
###

$(document).ready ->
  validate_open_id = () ->
    if $('#open_id_username').val().length > 0
      return true
    else
      return false
  $('#do_open_id_login').click () ->
    if validate_open_id()
      open_id = $('#open_id_username').val()
      form = $('#open_id_form')
      form.append('<input type="hidden" name="open_id" value="' + encodeURI(open_id) + '"/>')
      form.submit()
    else
      $('#open_id_input_group').addClass('has-error')
      $('.alert-danger').show()
      return false

