#set :output, '/path/to/log/chron.log'
env :PATH, ENV['PATH']

every 2.hours do
  rake "feeds:generate"
end

every 10.minutes do
  rake "cache:generateLikes"
end