# frozen_string_literal: true

puts "\n== Upload startup images ======================================================"
Rails.root.join('db/seeds/images').glob('*').map do |folder|
  folder.glob('*').map { |file| { file => folder.basename.to_s.to_i } }
end.flatten.inject(:merge).each do |img_file, darkness|
  puts "upload #{img_file}"
  image = Image.new(darkness: darkness)
  image.file.attach(io: File.open(img_file), filename: img_file.basename, content_type: "image/#{img_file.extname}")
  image.save!
end

# TODO: there should be something different
puts "\n== Upload startup messages ===================================================="
Message.create!(text: 'Hello World!')
Message.create!(text: 'Мяу :3', darkness: 1)
Message.create!(text: 'Ещё работаешь?', darkness: 5)
Message.create!(text: 'Я твой новый котик')
Message.create!(text: 'Как дела?', darkness: 3)
Message.create!(text: 'haskell - лучший язык', darkness: 4)
