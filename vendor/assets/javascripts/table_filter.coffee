(($) ->
  'use strict'
  class TableFilter
    constructor: (element) ->
      @element = element
      @target  = $(@element.data('table-filter-target'))
      @allRows = $('tbody tr:not(.tr-no-record)', @target)
      colspan = if @target.data('no-record-span')?
        @target.data('no-record-span')
      else
        $('thead th', @target).size()

      message = if @target.data('no-record')?
        @target.data('no-record')
      else
        'No records found'

      @noRecordRow = $("<tr class='tr-no-record'><td colspan=#{colspan}>#{message}</td></tr>")
    filter: ->
      $('.tr-no-record', @target).remove()
      keyword = @element.val().toLowerCase()

      $toShow = if keyword is ''
        @allRows
      else
        @allRows.filter ->
          trText = $(this).clone().find('.btn').remove().end().text().toLowerCase()
          trText.indexOf(keyword) > -1

      $toShow.show()
      @allRows.not($toShow).hide()

      if $toShow.size() is 0
        $('tbody', @target).append(@noRecordRow)

  $.fn.tableFilter = ->
    @each ->
      data = $(this).data('table-filter')
      unless data?
        $(this).data('table-filter', data = new TableFilter($(this)) )
      data.filter()

  $ ->
    $(document).on 'keyup', '[data-table-filter-target]', (e) ->
      $(this).tableFilter()
) jQuery