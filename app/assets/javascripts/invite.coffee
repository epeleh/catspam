$(document).on 'turbolinks:load', ->
  return unless page.controller == 'invite' && page.action == 'index'

  if current_user?
    $('.template #subscriber_name').html($('.toolbar [type="text"]').val())
    $('.template #current_user_email').html(current_user.email)
    $('.template #current_user_name').html(current_user.name)

  $('.radio-btns [type="radio"]').click ->
    $('.radio-btns [type="radio"]').removeAttr('checked')
    $("#invite_type_#{@value}").attr('checked', 'checked')
    $('.template').css('display', 'none')
    $("#template_#{@value}").removeAttr('style')

  $('.toolbar [type="email"]').on('input', ->
    name_input = $('.toolbar [type="text"]')
    if ($(@).data('previous_value') || '').split('@')[0] == name_input.val() || name_input.val() == ''
      name_input.val($(@).val().split('@')[0])
      name_input.trigger('input')

    $(@).data('previous_value', $(@).val())
  ).trigger('input')

  $('.toolbar [type="text"]').on 'input', ->
    $('.template #subscriber_name').html(@value.trim())

  $('.toolbar [type="submit"]').click (e) ->
    e.preventDefault()

    # TODO: remove two lines below
    alert('Временно отключил эту кнопку.\nПланирую скоро ресетнуть БД - пока рано добавлять пользователей')
    return false

    $('.toolbar [type="email"]').val($('.toolbar [type="email"]').val().trim())
    $('.toolbar [type="text"]').val($('.toolbar [type="text"]').val().trim())

    url = $(@)[0].form.action
    type = 'POST'
    data = JSON.stringify({
      email: $('.toolbar [type="email"]').val(),
      name: $('.toolbar [type="text"]').val(),
      invite_type: $('.radio-btns [type="radio"][checked="checked"]').val() || '0'
    })

    success = ->
      email = $('.toolbar [type="email"]').val()
      alert("Письмо отправлено на #{email}!")
      Turbolinks.visit('/')

    error = (data) ->
      if data.responseJSON?
        alert('Что-то не так.\nИзвини, было лень сделать красиво:\n' + JSON.stringify(data.responseJSON, null, 2))
      else
        alert('Сайт упал, лол')

    $.ajax({url, type, data, success, error})
