#!/usr/bin/env python3
import http.server
import socketserver
import os

PORT = 5000
HOST = "0.0.0.0"

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        # Disable caching for Replit preview
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        self.send_header('Pragma', 'no-cache')
        self.send_header('Expires', '0')
        super().end_headers()
    
    def log_message(self, format, *args):
        # Custom logging
        print(f"[{self.address_string()}] {format % args}")

os.chdir(os.path.dirname(os.path.abspath(__file__)))

Handler = MyHTTPRequestHandler

print(f"Starting server on {HOST}:{PORT}")
print(f"Serving files from: {os.getcwd()}")

with socketserver.TCPServer((HOST, PORT), Handler) as httpd:
    print(f"Server running at http://{HOST}:{PORT}/")
    print("Press Ctrl+C to stop the server")
    httpd.serve_forever()
