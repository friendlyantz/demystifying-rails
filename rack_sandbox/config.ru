# run do |env|
  # [200, { "some_header" => "lalala"}, ["Hello World"]]
# end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  # binding.irb

  case req.path_info
  when /hello/
    [200, { "content-type" => "text/html" }, ["Hello World🌎"]]
  when /lala/
    [200, { "some-header" => "badabing" }, ["💃🏼lalala🕺🏼"]]
  else
    [404, { "content-type" => "text/html" }, ["Not Found 🤷🏼‍♂️"]]
  end
end

run app
