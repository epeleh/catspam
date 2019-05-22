#= require jquery3
#= require jquery_ujs
#= require activestorage
#= require turbolinks
#= require cookies
#= require_self
#= require_tree .

$.ajaxSetup {
  dataType: 'json',
  contentType: 'application/json; charset=utf-8',
  beforeSend: (xhr) -> xhr.setRequestHeader('Authorization', Cookies.get('Authorization')),
}

$(document).on 'turbolinks:load', ->
  window.page = {
    controller: $('body').data('controller'),
    action: $('body').data('action'),
  }
  window.current_user = JSON.parse($('meta[name="current_user"]').attr('content'))
