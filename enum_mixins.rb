# Project to mimic Enumerable methods and practice mixins, and passing blocks and procs
module Enumerable

  def my_each
    raise LocalJumpError, "No block given (yield)" unless block_given?
    for arg in self
      yield(arg)
    end
  end

  def my_each_with_index
    raise LocalJumpError, "No block given (yield)" unless block_given?
    count = 0
    for arg in self
      yield(arg, count)
      count += 1
    end
  end

  def my_select
    raise LocalJumpError, "No block given (yield)" unless block_given?
    selected = Array.new
    self.my_each_with_index { |arg, index|
      if yield(arg)
        selected << self[index]
      end
    }
    selected
  end

  def my_all?
    raise LocalJumpError, "No block given (yield)" unless block_given?
    self.my_each { |arg| return false if yield(arg) == false }
    true
  end

  def my_any?
    raise LocalJumpError, "No block given (yield)" unless block_given?
    self.my_each { |arg| return true if yield(arg) == true }
    false
  end

  def my_none?
    raise LocalJumpError, "No block given (yield)" unless block_given?
    !(self.my_any? { |arg| yield(arg) })
  end

  def my_count(*count)
    counter = 0
    if count.size > 0
      return ArgumentError, "Wrong number of arguments" if count.size > 1
      @count = count[0]
      self.each { |arg| counter += 1 if @count == arg }
      warn("given block not used") if block_given?
    else
      return self.size unless block_given?
      self.each { |arg| counter += 1 if yield(arg) }
    end
    counter
  end

  # my_map just takes a block
#  def my_map
#    self_map = Array.new
#    self.each { |arg| block_given? ? self_map << yield(arg) : self_map << arg }
#    self_map
#  end

  # my_map just takes a proc
#  def my_map(my_proc=Proc.new { |x| x })
#    self_map = Array.new
#    self.each { |arg| self_map << my_proc.call(arg) }
#    self_map
#  end

  # my map takes a proc and a block, or just a proc, but not just a block
#  def my_map(my_proc=false)
#    self_map = Array.new
#    self.each { |arg| block_given? ? self_map << yield(my_proc.call(arg)) : self_map << my_proc.call(arg)
#    self_map
#  end


  # my_map takes a proc and/or a block
  def my_map(my_proc=Proc.new { |x| x })
    self_map = Array.new
    self.each { |arg| block_given? ? self_map << yield(my_proc.call(arg)) : self_map << my_proc.call(arg) }
    self_map
  end

  def my_inject(memo=false)
    return LocalJumpError, "Requires block" unless block_given?
    self.each { |arg|
      if !memo
        memo = arg
        next
      end
      memo = yield(memo, arg) }
    memo
  end

end

# test functionality of #my_inject
def multiply_els(arr)
  return ArgumentError, "Must pass array to method" unless arr.is_a?(Array)
  result = arr.my_inject { |product, arg| product * arg }
end
