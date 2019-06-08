# frozen_string_literal: true

module ApplicationHelper
  def opposite_darkness(darkness)
    {
      1 => 3,
      2 => 4,
      3 => 5,
      4 => 2,
      5 => 1
    }.freeze[darkness.to_i]
  end

  def darkness_to_color(darkness)
    "##{(63.75 * (darkness * 5 % 6 - 1)).to_i.to_s(16) * 3}"
  end

  def report_data(report)
    subscriber = { only: %i[id email name active] }
    image = { only: %i[id darkness], methods: :url }
    message = { only: %i[id text darkness] }
    votes = { only: %i[id value], include: { subscriber: subscriber } }
    posts = { only: :id, methods: %i[stars weekday], include: { image: image, message: message, votes: votes } }
    report.to_json(only: :id, include: { posts: posts })
  end

  def translate_day(day)
    {
      sunday: 'Воскресенье',
      monday: 'Понедельник',
      tuesday: 'Вторник',
      wednesday: 'Среда',
      thursday: 'Четверг',
      friday: 'Пятница',
      saturday: 'Суббота'
    }.freeze[day.to_sym.downcase]
  end

  def translate_time(time)
    local_time = time.in_time_zone('Almaty')
    "#{translate_day(local_time.strftime('%A'))}, #{local_time.strftime('%d.%m.%y %H:%M')}"
  end
end
