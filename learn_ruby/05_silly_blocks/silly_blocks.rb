def reverser
  reverse = Array.new
  yield.split.each do |a_word|
    letters = a_word.chars
    srettel = Array.new
    for i in 0..letters.length-1
      srettel.push(letters.pop)
    end
    reverse.push(srettel.join)
  end
  sdrow = reverse.join(" ")
end

def adder(x=1)
  yield + x
end

def repeater(x=1)
  x.times do
    yield
  end
end
