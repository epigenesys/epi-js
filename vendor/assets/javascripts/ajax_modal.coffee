(($) ->
  $.ajaxModal = (url, params) ->
    $.get url, params, (data) ->
      $modal = if $('#modalWindow').size() > 0 then $('#modalWindow') else $('<div>').addClass('modal fade').attr('id', 'modalWindow')
      $('body').append($modal.html(data).modal())
      $(document).trigger('ajax-modal-show')
      
      # Bootstrap 2.x the events are shown and hidden
      # Bootstrap 3.x the event is hidden.bs.modal and shown.bs.modal
      $modal.on 'hidden.bs.modal hidden', (e) ->
        if e.target is this
          $(@).remove()
      .on 'shown.bs.modal shown', (e) ->
        setTimeout("$('#modalWindow [autofocus]').first().focus()", 0)
        $(document).trigger('ajax-modal-shown')
) jQuery

$ ->
  $(document.body).on 'click', 'a.ajax-modal', (e) ->
    e.preventDefault()
    $.ajaxModal $(@).attr('href'), $(@).data('params')