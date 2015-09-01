def measure(n=1)
  timey = Array.new
  avg_time = 0

  n.times do
    start = Time.now
    yield
    timey.push(Time.now - start)
  end

  timey.each do |avg|
    avg_time += avg
  end

  avg_time / n
end
