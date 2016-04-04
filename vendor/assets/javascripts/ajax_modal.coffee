(($) ->
  'use strict'
  $.ajaxModal = (url, params) ->
    $.get url, params, (data) ->
      $modal = if $('#modalWindow').size() > 0 then $('#modalWindow') else $('<div>').addClass('modal fade').attr('id', 'modalWindow')
      
      alreadyShown = $modal.hasClass('in')

      $('body').append($modal.html(data).modal())
      $(document).trigger('ajax-modal-show')
      
      if alreadyShown
        $(document).trigger('ajax-modal-shown')
      
      # Bootstrap 2.x the events are shown and hidden
      # Bootstrap 3.x the event is hidden.bs.modal and shown.bs.modal
      $modal.on 'hidden.bs.modal hidden', (e) ->
        if e.target is this
          $(@).remove()
      .on 'shown.bs.modal shown', (e) ->
        setTimeout("$('#modalWindow [autofocus]').first().focus()", 0)
        $(document).trigger('ajax-modal-shown')
        
  $ ->
    $(document.body).on 'click', 'a.ajax-modal, a[data-toggle="ajax-modal"]', (e) ->
      e.preventDefault()
      $.ajaxModal $(@).attr('href'), $(@).data('params')
) jQuery