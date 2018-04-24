(($) ->
  'use strict'
  class GenericVisibilityChecker
    constructor: (element) ->
      @element = element
      @scope   = @element.closest(@element.data('visibility-map-scope') ? document)
      @action  = @element.data('visibility-map-action') ? 'show'
      @map     = @element.data('visibility-map')
      @allFields = $($.unique $.map @map, (val) => $(val, @scope).get())

    check: ->
      fieldsForValue = $ $.unique $.map @getValue(), (value) => $(@map[value], @scope).get()

      if @action is 'show'
        toShow = fieldsForValue
        toHide = @allFields.not(fieldsForValue)
      else
        toHide = fieldsForValue
        toShow = @allFields.not(fieldsForValue)

      toShow.show()
      toShow.trigger('visibility.show')

      toHide.hide()
      toHide.trigger('visibility.hide')

    hideAll: ->
      @allFields.hide()
      @allFields.trigger('visibility.hide')

    showAll: ->
      @allFields.show()
      @allFields.trigger('visibility.show')

    getValue: ->
      $.makeArray(@element.val())

  class CheckboxVisibilityChecker extends GenericVisibilityChecker
    getValue: ->
      $.map $("input[type='checkbox'][name='#{@element.attr('name')}']:checked"), (inputElement) ->
        $(inputElement).val()

  $.fn.setVisibility = (action) ->
    @each ->
      data = $(this).data('visibility-checker')
      unless data?
        checkerClass = if $(this).is("input[type='checkbox']") then CheckboxVisibilityChecker else GenericVisibilityChecker
        $(this).data('visibility-checker', data = new checkerClass $(this))
      action ?= 'check'
      data[action]()

  $ ->
    $('input[data-visibility-map]:checked, select[data-visibility-map]').setVisibility()

    $(document.body).on('visibility.show', (e) ->
      $(':input:not([data-visibility-map-no-auto-enable])', $(e.target)).prop('disabled', false)
    ).on('visibility.hide', (e) ->
      $(':input', $(e.target)).prop('disabled', true)
    )

    $(document.body).on 'change', '[data-visibility-map]', (e) ->
      $(this).setVisibility()
) jQuery
