class String
  def capitalized?
    chars.first.upcase == chars.first
  end
end
# ^^^^does just what it says!


def translate (word)
# some main variables to help us go
  vowels = ['a','e','i','o','u'] # some vowels to check over.. maybe figure out regexp instead of iterator?
  words = word.scan(/[\w^']+|[[:punct:]]+/) # punctuation is its own "word", except apostrophes
  pig_words = Array.new
# look over each word in the string (now array)
  words.each do |a_word|
    big_head = a_word.capitalized?
    letters = a_word.chars
    ph = "" 

    v_start = /\Aaeiou/i =~ word.chars.first
    v_found = false
    i = 0
    /(?!')[[:punct:]]/ =~ a_word ? is_punc = true : is_punc = false
# Latinize, ignoring punctuation
    unless is_punc
      letters.each do |a_letter|
        if !v_start
          vowels.each do |a_vowel|
  # reproduce for translation purposes the consonant phoneme that starts the word, if any
            if a_letter == a_vowel
              v_found = true
              if a_vowel == 'u' and letters[i-1] == 'q'
                ph = letters[0..i].join
              else
                ph = letters[0..i-1].join
              end
            end
# first vowel found.. consonant phoneme complete! leave now!
            break if v_found
          end
# same! gotta get outta this iterator too
          v_found ? break : i += 1
        end
      end
    end
# put the individual words together, ignoring punctuation
    unless is_punc
      if v_start
        pig_word = a_word + 'ay'
      else
        a_word.slice! ph
        pig_word = a_word + ph + 'ay'
      end
    else
      pig_word = a_word
    end
# capitalize if was capitalized
    big_head ? pig_words.push(pig_word.capitalize) : pig_words.push(pig_word)
  end

# put the final string together, checking if there is punctuation (or if at the end) to decide if a space needs to follow
  big_pig_word = ""
  for j in 0...pig_words.length do
      unless /(?!')[[:punct:]]/ =~ pig_words[j+1] or pig_words[j] == pig_words.last
      big_pig_word += pig_words[j] + " "
    else
      big_pig_word += pig_words[j]
    end
  end
# return and output that sucker
  p big_pig_word
end
