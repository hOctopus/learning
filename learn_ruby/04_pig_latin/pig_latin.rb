class String
  def capitalized?
    chars.first.upcase == chars.first
  end
end

def translate (word)

  vowels = ['a','e','i','o','u']
  words = word.scan(/[\w^']+|[[:punct:]]+/)
  pig_words = Array.new

  words.each do |a_word|
    big_head = a_word.capitalized?
    letters = a_word.chars
    ph = "" 

    v_start = /\Aaeiou/i =~ word.chars.first
    v_found = false
    i = 0
    /(?!')[[:punct:]]/ =~ a_word ? is_punc = true : is_punc = false

    unless is_punc
      letters.each do |a_letter|
        if !v_start
          vowels.each do |a_vowel|

            if a_letter == a_vowel
              v_found = true
              if a_vowel == 'u' and letters[i-1] == 'q'
                ph = letters[0..i].join
              else
                ph = letters[0..i-1].join
              end
            end

            break if v_found
          end

          v_found ? break : i += 1
        end
      end
    end

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

    big_head ? pig_words.push(pig_word.capitalize) : pig_words.push(pig_word)
  end

  big_pig_word = ""
  for j in 0...pig_words.length do
      unless /(?!')[[:punct:]]/ =~ pig_words[j+1] or pig_words[j] == pig_words.last
      big_pig_word += pig_words[j] + " "
    else
      big_pig_word += pig_words[j]
    end
  end

  p big_pig_word
end
