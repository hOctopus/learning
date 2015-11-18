class Friend
  def greeting(bud = nil)
    !bud ? "Hello!" : "Hello, #{ bud}!"
  end
end
