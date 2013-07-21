every 30.seconds do
  if ENV['ADMIN_PRODUCTION']
    rake 'app:poll'
  else
    puts 'Polling...'
  end
end

