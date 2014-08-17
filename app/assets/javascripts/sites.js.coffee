# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
openPopupWindow = (openid) ->
  window.open('/openid_begin?openid_identifier='+encodeURIComponent(openid), 'openid_popup', 'width=790,height=580')

handleOpenIDResponse = (openid_args) ->
  document.getElementById('ops').style.display = 'none'
  document.getElementById('bucket').innerHTML = 'Verifying OpenID response'
  YAHOO.util.Connect.asyncRequest('GET', '/openid_finish?'+openid_args,
      {'success': (r) ->
              document.getElementById('bucket').innerHTML = r.responseText; 
         }) 
