# Put an instance of the redis data store in a global variable
$redis = Redis.new(:host => 'localhost', :port => 6379)
