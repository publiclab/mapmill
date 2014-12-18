# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  $('body').on('keypress keyup', '#open_id_username', ->
    if $('#open_id_input_group').hasClass('has-error')
      $('#open_id_input_group').removeClass('has-error')

    if $('.alert-danger').is(':visible')
      $('.alert-danger').hide()

    val = $(this).val()
    setTimeout (-> 
        $('#open_id_part_username').text(val)
        return
    ), 0
    return
  )
 
$ ->
  validate_open_id = () ->
    if $('#open_id_username').val().length > 0
      return true
    else
      return false

  $('.datepicker').datepicker({
      clearBtn: true,
      autoclose: true,
      forceIframeTransport: true,
      todayBtn: "linked" 
  })


  $('#login_via_open_id_btn').click( ->
      form = $('#site_form') 
      logged_in = $('#logged_in').val()
      if logged_in != "1"
        bootbox.dialog({
          #
          # @required String|Element
          #/
          message: '<div class="alert alert-warning">Note: Only <a href="http://publiclab.org">Publiclab</a> is currently supported as OpenID provider!</div><div class="alert alert-info">Please enter your OpenID endpoint, you will then be redirected to publiclab.org to complete the login procedure. The OpenID is <strong>case sensitive!</strong></div><div class="input-group" id="open_id_input_group"><span class="input-group-addon glyphicon glyphicon-user input-desc">&nbsp;OpenID</span><input id="open_id_username" type="text" class="form-control" placeholder="Username"></div><div class="open_id_endpoint"><label class="open_id_part">http://publiclab.org/people/</label><label class="open_id_part" id="open_id_part_username"></label><label class="open_id_part">/identity</label>'
          #
          # @optional String|Element
          # adds a header to the dialog and places this text in an h4
          #/
          title: "Login with OpenID",
          #
          # @optional Function
          # allows the user to dismisss the dialog by hitting ESC, which
          # will invoke this function
          #/
          onEscape: () ->,
          #
          # @optional Boolean
          # @default: true
          # whether the dialog should be shown immediately
          #/
          show: true,
          #
          # @optional Boolean
          # @default: true
          # whether the dialog should be have a backdrop or not
          #/
          backdrop: true,
          #
          # @optional Boolean
          # @default: true
          # show a close button
          #/
          closeButton: true,
          #
          # @optional Boolean
          # @default: true
          # animate the dialog in and out (not supported in < IE 10)
          #/
          animate: true,
          #
          # @optional String
          # @default: null
          # an additional class to apply to the dialog wrapper
          #/
          className: "open_id_modal",
          #
          # @optional Object
          # @default: {}
          # any buttons shown in the dialog's footer
          #/
          buttons: {
          # For each key inside the buttons object...
          #
          # @required Object|Function
          #
          # this first usage will ignore the `success` key
          # provided and take all button options from the given object
          #/
            success: {
              #
              # @required String
              # this button's label
              #/
              label: "Take me there"
              #
              # @optional String
              # an additional class to apply to the button
              #/
              className: "btn-success",
              #
              # @optional Function
              # the callback to invoke when this button is clicked
              #/
              callback: () ->
                if validate_open_id()
                  open_id = $('#open_id_username').val()
                  form.append('<input type="hidden" name="open_id" value="' + encodeURI(open_id) + '"/>')
                  form.submit() 
                else
                  $('#open_id_input_group').addClass('has-error')
                  return false
            },
            cancel: {
              className: "btn-default",
            },
          }
        })

      else
        form.submit()
  )
$('#toggle_sites_form').click ->
  $('.toggle-well').slideUp(200)
  $('.sites_form').delay(500).hide().removeClass('hidden-xs').slideDown(700)
  
    
