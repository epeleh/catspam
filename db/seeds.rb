# frozen_string_literal: true

puts '== Upload startup images ======================================================'

Rails.root.join('db/seeds/images').glob('*').map do |folder|
  folder.glob('*').map { |file| { file => folder.basename.to_s.to_i } }
end.flatten.inject(:merge).each do |img_file, darkness|
  puts "upload #{img_file}"
  image = Image.new(darkness: darkness)
  image.file.attach(io: File.open(img_file), filename: img_file.basename, content_type: "image/#{img_file.extname}")
  image.save!
end
