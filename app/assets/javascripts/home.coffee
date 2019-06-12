$(document).on 'turbolinks:load', ->
  return unless page.controller == 'home' && page.action == 'index'

  red_color = '#cc5c5c'
  green_color = '#5d9e5d'

  funny_smile = -> [':3', ':)', ':D', '♥'].shuffle()[0]
  sad_smile = -> [":'(", ':(', ':c', '>:('].shuffle()[0]

  $('.toolbar #subscribe-btn').bind('updateColor', ->
    $(@).css('color', if $(@).html() == 'Отписаться' then red_color else green_color)
  ).trigger('updateColor')

  $('.toolbar #subscribe-btn').click ->
    $(@).html(['Отписаться', 'Подписаться'].filter((x) => x != $(@).html())[0])
    $(@).trigger('updateColor')

    smile = $('.toolbar #smile')
    smile.html(if $(@).html() == 'Отписаться' then funny_smile() else sad_smile())
    smile.css('transition', 'none').css('opacity', 1)
    setTimeout (-> smile.css('transition', 'opacity .4s ease-in 2s').css('opacity', 0)), 1

    url = $(@)[0].form.action
    type = 'PUT'
    data = JSON.stringify({active: $(@).html() == 'Отписаться'})
    $.ajax({url, type, data})

  $('.toolbar [type="text"]').on 'input', ->
    $('.toolbar [type="submit"]').val('Поменять').removeAttr('title')
      .css('color', green_color).css('visibility', 'visible').css('cursor', 'pointer')

  $('.toolbar [type="submit"]').click (e) ->
    e.preventDefault()
    return if $(@).val() != 'Поменять'

    url = $(@)[0].form.action
    type = 'PUT'
    data = JSON.stringify({name: $('.toolbar [type="text"]').val()})

    success = -> $('.toolbar [type="submit"]').css('visibility', 'hidden')
    error = (data) ->
      btn = $('.toolbar [type="submit"]')
      btn.css('color', red_color).css('cursor', 'default')

      errors = data.responseJSON['name']
      if errors != null
        return btn.val('Слишком короткий') if errors.includes('is too short (minimum is 2 characters)')
        return btn.val('Слишком длинный') if errors.includes('is too long (maximum is 20 characters)')
        return btn.val('Уже занят') if errors.includes('has already been taken')

      title = 'Ты умный, разберёшься:\n /\\A([a-z0-9!@#$^]+[-_. ]?)*[a-z0-9!]+\\z/i'
      btn.attr({title}).val('Всё плохо')

    $.ajax({url, type, data, success, error})
