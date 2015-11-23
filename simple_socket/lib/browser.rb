require 'socket'
require 'json'

host = "localhost"
port = 3000

puts 'Welcome to the simplest web browser you will ever see.'
puts 'for GET requests, use format "GET [path]"'
puts 'for POST requests, use format "POST [path] [name] [email]"'
puts 'don\'t worry about case-sensitivity, i\'ll handle that.'
puts "enter \"QUIT\" to exit the browser\n\n"

def parse(input)
  params = Hash.new { |hash, key| hash[key] = Hash.new }
  command = input[0].upcase
  path = input[1]
  case command
    when "QUIT"
      puts "Good-bye!"
      exit
    when "GET"
      return "GET #{path} HTTP/1.0\r\nTime is: #{Time.now.ctime}\r\nContent-type: text/html\r\nServer: Simple Socket Server\r\n"
    when "POST"
      params[:person][:name] = input[2..-2].join(" ")
      params[:person][:email] = input[-1]
      body = params.to_json
      return "POST #{path} HTTP/1.0\r\nTime is: #{Time.now.ctime}\r\nContent-type: text/html\r\nServer: Simple Socket Server\r\nSize of Content: #{body.length} characters\r\n\r\n#{body}"
    else
      puts "I didn't understand. Please use command GET, POST, or QUIT."
      return false
    end
end

loop do
  print 'enter request: '
  input = gets.chomp
  request = parse(input.split(" "))
  unless request
    redo
  else
    socket = TCPSocket.open(host, port)
    socket.print(request)
    response = socket.read
    header, body = response.split("\r\n\r\n", 2)
    puts ''
    print body
    socket.close
  end
end
