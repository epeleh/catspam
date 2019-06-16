#= require jquery3
#= require jquery_ujs
#= require activestorage
#= require turbolinks
#= require cookies
#= require chart
#= require tooltip
#= require dynamic_width
#= require_self
#= require_tree .

# Array monkey patch
Array.prototype.shuffle = ->
  @.map((a) -> [Math.random(), a]).sort((a, b) -> a[0] - b[0]).map((a) -> a[1])

params = new Map(window.location.search.substring(1).split('&').map((x) -> x.split('=')))
if params.has('Authorization')
  Cookies.set('Authorization', params.get('Authorization'), {expires: 365})
  params.delete('Authorization')
  href = window.location.href.split('?')[0]
  params_str = Array.from(params).map(([k, v]) -> "#{k}=#{v}").join('&')
  window.location.replace "#{href}#{if params_str then '?' else ''}#{params_str}"

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
