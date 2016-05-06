(($) ->
  'use strict'
  class OptionFilter
    constructor: (element) ->
      @element      = element
      @filterTarget = $(@element.data('option-filter-target'))
      @disableEmpty = @element.data('option-filter-disable-empty')?
      
      @filterTarget.each ->      
        unless $(this).data('option-filter-all-options')?
          $(this).data('option-filter-all-options', $('option', $(this)))
      
    filter: ->
      valueSelected = @element.val().toString()
      disableEmpty  = @disableEmpty
      
      @filterTarget.each ->
        $toShow = $(this).data('option-filter-all-options').filter("[data-option-filter-value='#{valueSelected}'], :not([data-option-filter-value])")
        
        $(this).html($toShow).val('').trigger('change.option-filter')      
        $(this).prop('disabled', disableEmpty and ($toShow.size() is 0))
    
  $.fn.optionFilter = ->
    @each ->
      data = $(this).data('option-filter')
      unless data?
        $(this).data('option-filter', data = new OptionFilter $(this))
      data.filter()
      
  $ ->
    $('input[data-visibility-map]:checked, select[data-visibility-map]').optionFilter()
    
    $(document.body).on 'change', '[data-option-filter-target]', (e) ->
      $(this).optionFilter()
    
) jQuery