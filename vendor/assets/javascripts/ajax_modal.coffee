(($) ->
  'use strict'
  $.ajaxModal = (url, params) ->
    $.get url, params, (data) ->
      $modal = if $('#modalWindow').length > 0
        $('#modalWindow')
      else
        $('<div id="modalWindow" class="modal fade" tabindex="-1" role="dialog"></div>')

      alreadyShown = $modal.hasClass('in')
      $modal.html(data)
      $('.modal-title', $modal).attr('id', 'modalWindowTitle')

      $modal.attr('aria-labelledby', 'modalWindowTitle')
      $('.modal-dialog', $modal).attr('role', 'document')

      $('body').append($modal.modal())
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
    $(document.body).on 'click', 'a.ajax-modal, [data-toggle="ajax-modal"]', (e) ->
      e.preventDefault()
      url = $(@).data('url') ? $(@).attr('href')
      $.ajaxModal url, $(@).data('params')
) jQuery
