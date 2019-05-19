$(document).on "turbolinks:load", ->
  return unless page.controller() == 'posts' && page.action() == 'index'
  console.log('posts index')

$(document).on "turbolinks:load", ->
  return unless page.controller() == 'posts' && page.action() == 'show'
  console.log('posts show')
