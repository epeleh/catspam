# frozen_string_literal: true

module ApplicationHelper
  def opposite_darkness(darkness)
    {
      1 => 3,
      2 => 4,
      3 => 5,
      4 => 2,
      5 => 1
    }.freeze[darkness]
  end

  def darkness_to_color(darkness)
    "##{(63.75 * (darkness * 5 % 6 - 1)).to_i.to_s(16) * 3}"
  end
end
