def caesar_cipher(input="", shift=0)
  output = Array.new
  input.scan(/./) do |char|
    if char =~ /\S/ && char =~ /[^[:punct:]]/
      shift.times do
        if char == 'z'
          char = 'a'
        elsif char == 'Z'
          char = 'A'
        else
          char.next!
        end
      end
    end
    output << char
  end
  output.join
end

puts caesar_cipher("Hi how are you", 5)
puts caesar_cipher("Bunga, bunga, baloney 3", 3)
puts caesar_cipher("zee is Zaye", 9)
