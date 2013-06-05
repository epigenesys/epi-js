(($) ->
  $.ajaxModal = (url, params) ->
    $.get url, params, (data) ->
      $modal = if $('#modalWindow').size() > 0 then $('#modalWindow') else $('<div>').addClass('modal fade').attr('id', 'modalWindow')
      $modal.html(data).modal().on 'hidden', (e) ->
        if e.target is this
          $(@).remove()
      .on 'show', (e) ->
        if e.target is this
          $(document).trigger('ajax-modal-show')
      .on 'shown', (e) ->
        if e.target is this
          $(document).trigger('ajax-modal-shown')
) jQuery

$ ->
  $(document.body).on 'click', 'a.ajax-modal', (e) ->
    e.preventDefault()
    $.ajaxModal $(@).attr('href'), $(@).data('params')