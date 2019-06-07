$(document).on 'turbolinks:load', ->
  return unless page.controller == 'posts' && page.action == 'show'
  post = $('#post').data()

  $('input[type="radio"]').click ->
    url = $(@)[0].form.action
    $.post(url, JSON.stringify {post_id: post.id, value: @value})
