(($) ->
  'use strict'
  class OptionFilter
    constructor: (element) ->
      @element      = element
      @filterTarget = $(@element.data('option-filter-target'))
      @allOptions   = $('[data-option-filter-value]', @filterTarget)
      
      @disableEmpty = @element.data('option-filter-disable-empty')?
      
    filter: ->
      valueSelected = @element.val().toString()
      
      filteredOptionsCount = 0

      if valueSelected is ''
        @allOptions.hide()
      else
        $toShow = @allOptions.filter("[data-option-filter-value='#{valueSelected}']").show()
        @allOptions.not($toShow).hide()
        filteredOptionsCount = $toShow.size()
        
      @filterTarget.val('').trigger('change.option-filter')
      @filterTarget.prop('disabled', @disableEmpty and (filteredOptionsCount is 0))
    
  $.fn.optionFilter = ->
    @each ->
      data = $(this).data('option-filter')
      unless data?
        $(this).data('option-filter', data = new OptionFilter $(this))
      data.filter()
      
  $ ->
    $('[data-option-filter-target]').optionFilter()
    
    $(document.body).on 'change', '[data-option-filter-target]', (e) ->
      $(this).optionFilter()
    
) jQuery