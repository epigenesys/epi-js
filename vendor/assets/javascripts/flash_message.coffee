(($) ->
  'use strict'
  $.flashAlert = (message, type, timeout = 6000, dismissLink) ->
    dismissLink ?= $.flashAlert.defaults.dismissLink
    $alert = $('<div>').addClass("alert fade in #{type}").append(message).append(dismissLink)
    if $('.flash-messages .alert').length > 2
      clearTimeout $('.flash-messages .alert:last').remove().data('timeout')
    $('.flash-messages').prepend($alert)
    $alert.data 'timeout', setTimeout(->
      $alert.alert('close')
    , timeout)
    true
  $.flashAlert.defaults = {
    dismissLink: '<a href="#" title="Hide this message" data-dismiss="alert" class="dismiss-flash">Dismiss</a>'
    affix: false
  }

  $ ->
    if $.flashAlert.defaults.affix and $('.navbar-static-top').length > 0
      $('.flash-messages').affix
        offset:
          top: ->
            $('.navbar-static-top').outerHeight(true)

    if $('.flash-messages .alert').length > 0
      $('.flash-messages .alert').addClass('in')
      setTimeout(
        ->
          $('.flash-messages .alert').alert('close')
        , 6000
      )
) jQuery
