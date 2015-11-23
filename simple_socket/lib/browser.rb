# Browser for the simple socket projects on The Odin Project
# Credit goes to the example Ruby server linked from The Odin Project, which helped me with the regular expressions...
# ...and to other students, whose solutions were invaluable in helping me understand how this project works...
# ...and whose code I borrowed and modified to that purpose.

require 'socket'
require 'json'

# WORKING DIRECTORY MUST MATCH PROGRAM DIRECTORY OR THIS WILL NOT WORK

host = "localhost"
port = 3000

puts 'Welcome to the simplest web browser you will ever see.'
puts 'for GET requests, use format "GET [path]"'
puts 'for POST requests, use format "POST [path] [name] [email]"'
puts 'don\'t worry about case-sensitivity, i\'ll handle that.'
puts "enter \"QUIT\" to exit the browser\n\n"

# this method figures out the appropriate request to send to the server...
# ...based on the user's input, allowing the user to type a single line at the prompt
def parse(input) # input comes as an array for easier parsing
  params = Hash.new { |hash, key| hash[key] = Hash.new } # hash for content to be sent in POST request
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
      body = params.to_json     # conversion to JSON so server can parse and convert to HTML
      return "POST #{path} HTTP/1.0\r\nTime is: #{Time.now.ctime}\r\nContent-type: text/html\r\nServer: Simple Socket Server\r\nSize of Content: #{body.length} characters\r\n\r\n#{body}"
    else
      puts "I didn't understand. Please use command GET, POST, or QUIT."
      return false
    end
end

# User input is given in a single line at the command prompt
# The input is run through the parse method, and the appropriate request is sent to the server
# Then the input is printed in HTML format, with a header showing content type, size, and date/time
loop do # browser runs until user enters quit command
  print 'enter request: '
  input = gets.chomp
  request = parse(input.split(" "))   # find the appropriate request to send
  unless request                      # try again if input wasn't valid
    redo
  else
    socket = TCPSocket.open(host, port)
    socket.print(request)
    response = socket.read
    header, body = response.split("\r\n\r\n", 2) # separates the response header from the printed output
    puts ''
    print body # printed output includes its own header for the user to read
    socket.close
  end
end
