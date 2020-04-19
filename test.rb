fichiers = []
dir = Dir.glob("img/*") { |file| fichiers << file }
puts fichiers.count