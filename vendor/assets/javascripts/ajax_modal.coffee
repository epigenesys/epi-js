(($) ->
  $.ajaxModal = (url, params) ->
    $.get url, params, (data) ->
      $modal = if $('#modalWindow').size() > 0 then $('#modalWindow') else $('<div>').addClass('modal fade').attr('id', 'modalWindow')
      $('body').append($modal.html(data).modal())
      $(document).trigger('ajax-modal-show')
      
      $modal.on 'hidden', (e) ->
        if e.target is this
          $(@).remove()
      .on 'shown', (e) ->
        if e.target is this
          $('input[autofocus]', $(this)).first().focus()
          $(document).trigger('ajax-modal-shown')
) jQuery

$ ->
  $(document.body).on 'click', 'a.ajax-modal', (e) ->
    e.preventDefault()
    $.ajaxModal $(@).attr('href'), $(@).data('params')