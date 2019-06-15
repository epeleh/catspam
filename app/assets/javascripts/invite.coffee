$(document).on 'turbolinks:load', ->
  return unless page.controller == 'invite' && page.action == 'index'

  red_color = '#cc5c5c'
  green_color = '#5d9e5d'

  $('.toolbar #template_false').click ->
    url = $(@)[0].form.action
    console.log(@value)
#    $('.template').css('display', 'none')
#    $("#template_#{$(@)}").css('display', 'none')
