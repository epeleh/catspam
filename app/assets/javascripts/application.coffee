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
  params = new Map(window.location.search.substring(1).split('&').map((x) -> x.split('=')))
  if params.has('Authorization')
    Cookies.set('Authorization', params.get('Authorization'), {expires: 365})
    params.delete('Authorization')
    href = window.location.href.split('?')[0]
    params_str = Array.from(params).map(([k, v]) -> "#{k}=#{v}").join('&')
    window.location.href = "#{href}#{if params_str then '?' else ''}#{params_str}"

  window.page = {
    controller: $('body').data('controller'),
    action: $('body').data('action'),
  }
  window.current_user = JSON.parse($('meta[name="current_user"]').attr('content'))
