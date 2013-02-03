(($) ->
  $.flashAlert = (message, type, timeout = 6000) ->
    $alert = $('<div>').addClass("alert fade in #{type}").append($('<a>').data('dismiss', 'alert').addClass('close').html('&times;')).append(message)
    if $('.flash-messages .alert').size() > 2
      clearTimeout $('.flash-messages .alert:last').remove().data('timeout')
    $('.flash-messages').prepend($alert)
    $alert.data 'timeout', setTimeout(->
      $alert.alert('close')
    , timeout)
    true
) jQuery

$ ->
  if $('.flash-messages .alert').size() > 0
    $('.flash-messages .alert').addClass('in')
    setTimeout("$('.flash-messages .alert').alert('close');", 6000)