(($) ->
  $.fn.setVisibility = ->
    @each ->
      unless $(@).data('fieldList')?
        $(@).data 'fieldList', $.unique $.map $(@).data('visibility-map'), (val) -> $(val).get()            
        
      $toShow = $($(@).data('visibility-map')[$(@).val()])
      $toShow.show().trigger('visibility.show').find('input, select, textarea').prop 'disabled', false
      
      $($(@).data('fieldList')).not($toShow).hide().trigger('visibility.hide').find('input, select, textarea').prop 'disabled', true
      
) jQuery

$ ->
  $(document.body).on 'change', '[data-visibility-map]', ->
    $(@).setVisibility()

  $('input[data-visibility-map]:checked, select[data-visibility-map]').setVisibility()