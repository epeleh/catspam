$(document).on 'turbolinks:load', ->
  return unless page.controller == 'home' && page.action == 'index'
