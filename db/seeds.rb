# frozen_string_literal: true

puts "\n== Upload startup images ======================================================"
Rails.root.join('db/seeds/images').glob('*').sort.map do |folder|
  folder.glob('*').sort.map { |file| { file => folder.basename.to_s.to_i } }
end.flatten.inject(:merge).each do |img_file, darkness|
  puts "upload #{img_file}"
  image = Image.new(darkness:)
  image.file.attach(io: File.open(img_file), filename: img_file.basename, content_type: "image/#{img_file.extname}")
  image.save!
end

puts "\n== Upload startup messages ===================================================="
Rails.root.join('db/seeds/messages.txt').read.each_line do |line|
  next if line.blank?
  darkness, text = line[0...-1].split(' ', 2).map(&:strip)
  darkness = darkness.to_i.zero? ? nil : darkness.to_i
  puts %(upload "#{text}" #{"(#{darkness})" if darkness})
  Message.create!(darkness:, text:)
end
