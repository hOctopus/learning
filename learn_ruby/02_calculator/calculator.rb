def add(num1,num2)
  num1+num2
end

def subtract(num1,num2)
  num1-num2
end

def sum(numbers)
  total = 0
  numbers.each do |num|
    total += num
  end
  total
end

def multiply(numbers)
  total = 1
  numbers.each do |num|
    total *= num
  end
  total
endm

def power(a,b)
  a**b
end

def factorial(n)
  return "error: not a positive integer" if n < 0 or !(n.is_a? Integer)
  k = 1
  while n > 0
    n.times do
      k, n = k*n, n-1
    end
  end
  k
end
