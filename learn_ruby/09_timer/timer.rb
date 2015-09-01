class Timer

  def initialize
    @seconds = 0
  end

  def seconds
    @seconds
  end

  def seconds=(seconds)
    @seconds = seconds
  end

  def time_string
    hrs = (@seconds / 3600).to_s
    mins = ((@seconds % 3600) / 60).to_s
    secs = ((@seconds % 3600) % 60).to_s
    col = ":"
    sprintf("%02d", hrs) + col + sprintf("%02d", mins) + col + sprintf("%02d", secs)
  end

end
