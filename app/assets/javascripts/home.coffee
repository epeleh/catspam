$(document).on 'turbolinks:load', ->
  return unless page.controller == 'home' && page.action == 'index'

  funny_smile = -> [':3', ':)', ':D', '♥', '✔'].shuffle()[0]
  sad_smile = -> [":'(", ':(', ':c', '>:(', '✕'].shuffle()[0]

  $('.toolbar #subscribe-btn').bind('updateColor', ->
    $(@).css('color', if $(@).html() == 'Отписаться' then '#cc5c5c' else '#5d9e5d')
  ).trigger('updateColor')

  $('.toolbar #subscribe-btn').click ->
    $(@).html(['Отписаться', 'Подписаться'].filter((x) => x != $(@).html())[0])
    $(@).trigger('updateColor')
    smile = $('.toolbar #smile')
    smile.html(if $(@).html() == 'Отписаться' then funny_smile() else sad_smile())
    smile.css('transition', 'none').css('opacity', 1)
    setTimeout (-> smile.css('transition', 'opacity .4s ease-in 2s').css('opacity', 0)), 1

  $('.toolbar [type="text"]').on 'input', ->
    $('.toolbar [type="submit"]').css('visibility', 'visible')

  $('.toolbar [type="submit"]').click (e) ->
    $(@).css('visibility', 'hidden')
    e.preventDefault()
