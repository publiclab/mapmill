###
## global js functions
###


validate_open_id = () ->
    if $('#open_id_username').val().length > 0
      return true
    else
      return false
