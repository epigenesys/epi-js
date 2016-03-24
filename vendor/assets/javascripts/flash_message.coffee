(($) ->  
  $.flashAlert = (message, type, timeout = 6000, dismissLink) ->
    dismissLink ?= $.flashAlert.defaults.dismissLink
    $alert = $('<div>').addClass("alert fade in #{type}").append(message).append(dismissLink)
    if $('.flash-messages .alert').size() > 2
      clearTimeout $('.flash-messages .alert:last').remove().data('timeout')
    $('.flash-messages').prepend($alert)
    $alert.data 'timeout', setTimeout(->
      $alert.alert('close')
    , timeout)
    true
  $.flashAlert.defaults = {
    dismissLink: '<a href="#" title="Hide this message" data-dismiss="alert" class="dismiss-flash">Dismiss</a>'
  }
) jQuery

$ ->
  if $('.flash-messages .alert').size() > 0
    $('.flash-messages .alert').addClass('in')
    setTimeout("$('.flash-messages .alert').alert('close');", 6000)