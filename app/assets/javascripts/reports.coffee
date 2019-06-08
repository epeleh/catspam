$(document).on 'turbolinks:load', ->
  return unless page.controller == 'reports' && page.action == 'show'
  report = JSON.parse $('#report').attr('data')

  weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
  posts = report.posts.sort((a, b) -> weekdays.indexOf(a) - weekdays.indexOf(b))
  images = posts.map (x) ->
    img = new Image()
    img.src = x.image.url
    img.onload = -> @height = 148 * @height / @width; @width = 148
    img

  data = {
    labels: weekdays,
    datasets: [
      {
        type: 'line',
        data: posts.map((x) -> x.stars),
        showLine: false,
        hitRadius: 30
      },
      {
        type: 'bar',
        data: posts.map((x) -> x.stars),
        label: 'Stars',
        borderWidth: 1,
        backgroundColor: 'rgba(0, 255, 0, .13)'
      },
    ],
  }

  options = {
    responsive: false,
    layout: {padding: {top: 100, bottom: 40}},
    legend: {display: false},
    tooltips: {enabled: false},
    scales: {
      xAxes: [{ticks: {display: false}, gridLines: {display: false}, categoryPercentage: 0.6}],
      yAxes: [{display: false, ticks: {beginAtZero: true}}],
    },
  }

  chart = new Chart($('#chart'), {title: {text: 'Weekly cats'}, type: 'bar', data, options})
  images.forEach((img, i) -> chart.config.data.datasets[0]._meta[chart.id].data[i]._model.pointStyle = img)

  $('#chart').click (event) ->
    Turbolinks.visit("/posts/#{posts[Math.floor(event.offsetX / (@width / 5))].id}")
