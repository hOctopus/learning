require 'jumpstart_auth'
require 'twitter'
require 'bitly'

Bitly.use_api_version_3

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing MicroBlogger"
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    message.size <= 140 ? @client.update(message) : (puts "Warning: Tweet must be 140 or fewer characters including spaces.")
  end

  def followers_list
    @client.followers.collect { |follower| @client.user(follower).screen_name }
  end

  def friends_list
    @client.friends.collect { |friend| @client.user(friend) }
  end

  def spam_my_followers(message)
    followers_list.each { |follower| dm(follower, message) }
  end

  def dm(target, message)
    puts "Trying to send #{target} this direct message!"
    puts message
    message = "d @#{target} #{message}"
    followers_list.include?(target) ? tweet(message) : (puts "Failed: You can only direct message followers.")
  end

  def everyones_last_tweet
    friends = friends_list.sort_by { |friend| friend.screen_name.downcase }
    friends.each { |friend|
      timestamp = friend.status.created_at.strftime("%A, %b %d, %Y")
      puts "#{friend.screen_name} said on #{timestamp}...\n#{friend.status.text}\n\n" }
  end

  def shorten(original_url)
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    puts "Shortening this URL: #{original_url}"
    return bitly.shorten(original_url).short_url
  end

  def run
    puts "Welcome to the JSL Twitter client!"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'spam' then spam_my_followers(parts[1..-1].join(" "))
        when 'elt' then everyones_last_tweet
        when 's' then shorten(parts[-1])
        when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
        else
          puts "Sorry, I don't know how to #{command}"
      end
    end
  end
end

blogger = MicroBlogger.new
blogger.run
