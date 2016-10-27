(($) ->
  'use strict'
  $(document).on('set-label', 'table.table-responsive-xs, .table-responsive-sm', ->
    $('thead th', $(this)).each (index) ->
      label = if $(this).data('label')? then $(this).data('label') else $(this).text()
      $("tr td:nth-child(#{index + 1})", $(this).closest('thead').next('tbody')).attr('data-label', label)
  )
  
  $('table.table-responsive-xs, table.table-responsive-sm').each ->
    $(this).trigger('set-label')
) jQuery
