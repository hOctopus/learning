def bubble_sort(args) # sorts array by value
  args.length.times {
    is_sorted = true
    args.each_index do |index|
      unless index == args.length - 1
        if args[index] > args[index + 1]
          is_sorted = false
          args[index], args[index + 1] = args[index + 1], args[index]
        end
      end
    end
    if is_sorted
      break
    end
  }
  puts args.inspect
end

def bubble_sort_by(args) # sorts array of strings by string length
  args.length.times {
    is_sorted = true
    args.each_index do |index|
      unless index == args.length - 1
        if yield(args[index], args[index + 1]) > 0
          is_sorted = false
          args[index], args[index + 1] = args[index + 1], args[index]
        end
      end
    end
    if is_sorted
      break
    end
  }
  puts args.inspect
end

bubble_sort([3,9,5,8,4])
bubble_sort([8,2,11,11,5,9,2])
bubble_sort(["Cephalopods","Arthropods"])

bubble_sort_by(["hi", "hello","hey"]) do |left, right|
  left.length - right.length
end

bubble_sort_by(["spider","octopus","tardigrade","squid"]) do |left, right|
  left.length - right.length
end
