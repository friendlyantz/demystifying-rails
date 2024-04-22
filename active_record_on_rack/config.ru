require File.join(__dir__, '../active_record/app')


app = proc do |env|
  req = Rack::Request.new(env)

  case req.path_info
  when /hello/
    [200, { 'content-type' => 'text/html' }, ['Hello World']]
  when '/users'
    [200, {},
     ["Users: \n" + User.all.map { |u| u.name }.join("\n")]]
  when /posts/, '/'
    [
      200,
      {},
      [
        <<~HTML
          <!DOCTYPE html>
          <html>
            <head>
              <title>Not Found</title>
              <meta charset="UTF-8">
            </head>
            <body>
              <h1>Posts📝:</h1>
              <ul>
                #{
                  Post.all.map do |p|
                    '<li>' +
                      p.content + ' by ' + p.user.name +
                    '</li>'
                  end
                    .join('<br>')
                }
              </ul>

              <a href="/form">Go to Form</a>
            </body>
          </html>
        HTML
      ]
    ]
  when '/form'
    if req.post?
      Post.create(user: User.find_by(name: 'Rubyists'), content: '🌶️' + req.params['comment'])
      form_data = req.params
      [ 200, { 'content-type' => 'text/html' },
       [ "Form data received: #{form_data.inspect}" + '<a href="/posts">Go to Posts</a>' ]
      ]
    else
      [
        200,
        { 'content-type' => 'text/html' },
        ['<form method="POST"><input type="text" name="comment"><input type="submit"></form>']
      ]
    end
  else
    [404, { 'content-type' => 'text/html' }, [File.open('404.html').read]]
  end
end

run app
