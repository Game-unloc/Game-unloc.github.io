#!/usr/bin/env ruby
require 'webrick'

port = 5000
host = '0.0.0.0'

puts "Starting WEBrick server on #{host}:#{port}"
puts "Serving files from: #{Dir.pwd}"

server = WEBrick::HTTPServer.new(
  Port: port,
  BindAddress: host,
  DocumentRoot: Dir.pwd,
  DirectoryIndex: ['index.html', 'index.htm'],
  AccessLog: [],
  Logger: WEBrick::Log.new($stdout, WEBrick::Log::INFO)
)

# Add custom MIME types
WEBrick::HTTPUtils::DefaultMimeTypes.store('js', 'application/javascript')
WEBrick::HTTPUtils::DefaultMimeTypes.store('json', 'application/json')

# Set Cache-Control headers to prevent caching in Replit
server.mount_proc '/' do |req, res|
  res['Cache-Control'] = 'no-cache, no-store, must-revalidate'
  res['Pragma'] = 'no-cache'
  res['Expires'] = '0'
end

trap('INT') { server.shutdown }

puts "Server running at http://#{host}:#{port}/"
puts "Press Ctrl+C to stop"

server.start
