require 'socket'
require 'json'

server = TCPServer.open(3000)
loop do
  Thread.start(server.accept) { |client|
    request = client.read_nonblock(256)
    method = request.split(" ")[0]
    path = Dir.pwd + request.gsub(/(GET |POST )/,'').gsub(/ HTTP.*/,'').split("\s")[0]
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
