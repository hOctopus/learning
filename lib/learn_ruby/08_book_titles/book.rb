class Book

  def title=(title)
    ttl = Array.new
    excep = %w[a an the this and or but about around behind below down up from in into of over on off to]

    title.split.each do |t|
      excep.include?(t) ? ttl.push(t) : ttl.push(t.capitalize)
    end
    ttl[0] = ttl[0].capitalize
    @title = ttl.join(" ")
  end

  def title
    @title
  end

end
