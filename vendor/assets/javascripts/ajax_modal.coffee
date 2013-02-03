(($) ->
  $.ajaxModal = (url) ->
    $.get url, (data) ->
      $modal = if $('#modalWindow').size() > 0 then $('#modalWindow') else $('<div>').addClass('modal fade').attr('id', 'modalWindow')
      $modal.html(data).modal().on 'hidden', ->
        $(@).remove()
      .on 'shown', ->
        $(document).trigger('ajax-modal-shown')
) jQuery

$ ->
  $(document.body).on 'click', 'a.ajax-modal', (e) ->
    e.preventDefault()
    $.ajaxModal $(@).attr('href')