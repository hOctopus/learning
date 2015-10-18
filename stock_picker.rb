def stock_picker(prices=[])
  day = sell_day = buy_day = 1
  high_price = low_price = prices[0]
  prices.each do |price|
    if price > high_price
      high_price = price
      sell_day = day
    elsif price < low_price
      low_price = price
      buy_day = day
    end
    day += 1

  end
  picks = ["\nStarting from Day 1 for array of stock prices $#{prices.inspect}:", "(Day 1 = array position 0, Day 2 = array position 1, etc.)", "Buy day: #{buy_day}", "Sell day: #{sell_day}\n"]
end

puts stock_picker([5,6,9,2,15])
puts stock_picker([19,1,11,55,2])
puts stock_picker([9,2,4,3,1])
puts stock_picker([1,5,500])
