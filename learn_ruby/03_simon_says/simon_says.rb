def echo (bark)
  bark
end

def shout (bark)
  bark.upcase
end

def repeat (bark,peat = 2)
  woof = bark
  (peat-1).times do
    woof += " " + bark
  end
  woof
end

def start_of_word(word,l)
  start = word.chars[0..(l-1)].join
end

def first_word(word)
  word.split.shift
end

def titleize(title)
  cap_title = Array.new
  stop_words = ["and","of","over","the"]
  title.split.each do |word|
    l_match = false;
    stop_words.each do |lil|
      l_match = true if word == lil and !cap_title.empty?
    end
    !l_match ? cap_title.push(word.capitalize) : cap_title.push(word)
  end
  cap_title.join(" ")
end
