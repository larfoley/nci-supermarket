require 'singleton'
require 'date'

class ActivityLogger
  include Singleton

  def log_page_request(request)
    data = "#{Time.now.to_s} , #{request.remote_ip} \n"
    File.write("request_log.txt", data, mode: "a")
  end

  def get_page_requests
    file = File.read('request_log.txt')
    requests = file.split("\n").map { |line| { date: line.split(',')[0], ip: line.split(',')[1] } }
  end

end
