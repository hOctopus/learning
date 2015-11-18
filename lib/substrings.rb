def substrings(word="", dictionary=[])
  subs = Hash.new
  dictionary.each do |entry|
    count = 0
    if entry =~ /#{word}/ || word =~ /#{entry}/
      dictionary.each do |counter|
        if entry == counter
          count += 1
        end
      end
      subs[entry] = count
    end
  end
  puts subs.inspect
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("below", dictionary)
dictionary = ["aardvark","an","and","and","banana","crystal","dominion","excitement","frappe","gluten","hivemind","in","dominion","pan"]
substrings("in", dictionary)
substrings("an", dictionary)
