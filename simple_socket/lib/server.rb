# Server for the simple socket projects on The Odin Project
# Credit goes to the example Ruby server linked from The Odin Project, which helped me with the regular expressions...
# ...and to other students, whose solutions were invaluable in helping me understand how this project works...
# ...and whose code I borrowed and modified to that purpose.

require 'socket'
require 'json'

# WORKING DIRECTORY MUST MATCH PROGRAM DIRECTORY OR THIS WILL NOT WORK

server = TCPServer.open(3000)
loop do # server runs forever
  Thread.start(server.accept) { |client| # allows for mutiple simultaneous requests, if that ever happens
    request = client.read_nonblock(256)  # makes sure server doesn't wait forever for the end of input
    method = request.split(" ")[0]
    path = Dir.pwd + request.gsub(/(GET |POST )/,'').gsub(/ HTTP.*/,'').split("\s")[0] # finds HTML in CWD
    header, body = request.gsub(/.*(?=HTTP)/,'').split("\r\n\r\n")
    unless File.exist?(path)
      client.puts "HTTP/1.1 404 Not Found\r\n\r\n"
      client.puts "404 Error: The requested resource \"#{path}\" does not exist."
    else
      client.puts "HTTP/1.1 200 OK\r\n\r\n"
      response = File.read(path)
      case method
        when "GET"
          client.puts header + "\r\nSize of File: #{response.length} characters\r\n" + response + "\r\n\r\n"
        when "POST"
          params = JSON.parse(body)
          user_info = "<li>User Name: #{params['person']['name']}</li><li>User Email: #{params['person']['email']}</li>"
          client.puts header + "\r\n\r\n"
          client.puts response.gsub('<%= yield %>', user_info) + "\r\n\r\n"
        end
      end
      client.close
    }
end
