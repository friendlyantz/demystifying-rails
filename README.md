breaking down Ruby on Rails parts and demistifying it

- [x] [Bundler](https://github.com/rubygems/bundler)
- [x] [Rake](https://github.com/ruby/rake)
  - [Fantastic free course by Avdi Grim](https://graceful.dev/courses/the-freebies/modules/rake-and-project-automation/topic/episode-129-rake/)
- [ ] [Rack](https://github.com/rack/rack)
- [x] [ActiveSupport](https://guides.rubyonrails.org/active_support_core_extensions.html)
- [x] hash_with_indifferent_access gotchas
- [ ] ActiveRecord
  - [ ] [basics](https://guides.rubyonrails.org/active_record_basics.html)
  - [ ] [migrations](https://guides.rubyonrails.org/active_record_migrations.html)
  - [ ] [validations](https://guides.rubyonrails.org/active_record_validations.html)
  - [ ] [callbacks](https://guides.rubyonrails.org/active_record_callbacks.html)
  - [ ] [Associations](https://guides.rubyonrails.org/association_basics.html)
  - [ ] [Query Interface](https://guides.rubyonrails.org/active_record_querying.html)
- [ ] ActiveModel
- [ ] ActiveMailer - running as standalone mailer
- [ ] ActiveJob
- [ ] others are too intertwined dependencies on the rest of rails to run individually - these are better run inside rails:
  - ActionCable,
  - ActionVeiew,
  - ActionController
- [ ] DSLs in rails/ruby - RSpec, Routes
- [ ] Routes: sinatra/hanami/Roda better for
- [ ] templates: ERB
- [ ] dissecting-rails book/site

# Bundle

```sh
bundle exec [command]

bundle init # create Gemfile
bundle add [gemname] # it adds versions, so remove them if required
bundle remove [gemname]
bundle install

bundle show # show all gems in Gemfile
bundle show [gemname] # show path
bundle info [gemname]
bundle open [gemname] # open gem in editor

bundle console # open irb with gems loaded
# [DEPRECATED] bundle console will be replaced by `bin/console` generated by `bundle gem <name>`
```

# Rake

[free course by Avdi Grim](https://graceful.dev/courses/the-freebies/modules/rake-and-project-automation/topic/episode-129-rake/)

## CLI docs

```sh
ri FileUtils
```

## Basic FileList and script

create a basic `Rakefile`:
> you need `pandoc` install, as it is used in the example

```ruby
task default: :html

files = Rake::FileList.new('**/*.md') do |fl|
  fl.exclude(/^excluded_dir/)
end

task html: files.ext('.html')

rule '.html' => '.md' do |t|
  sh "pandoc -o #{t.name} #{t.source}"
end
```

Run it

```sh
rake
# or for debugging
rake --trace
# dump list of prerequisites
rake -P
# for quiet output
rake -q
```

you can add trace rules to your Rakefile to help with debugging:

```ruby
Rake.application.options.trace_rules = true
```

## List files
  
```ruby
Rake::FileList.new('**/*')
  .pathmap("%f") # => ["README.md", "subdir", "ch1.md", "Rakefile"]
  .pathmap("%p") # => ["README.md", "subdir", "subdir/ch1.md", "Rakefile"]
  .pathmap("%n") # => ["README", "subdir", "ch1", "Rakefile"]
  .pathmap("%d") # => [".", "subdir", "subdir"]
  .pathmap("%x") # => ["md", "", "md", ""]
  .pathmap("%X") # => ["md", "", "md", ""]
```

## Directory

```ruby
directory 'ship_it🚢'

task list_files: 'ship_it🚢' do # dependency dir
  # ...
```

## Cleaning generated files

```ruby
task :clean do
  rm_rf 'ship_it🚢'
end
```

## parallel execution

refer Rakefile in `rake_sandbox/2_parallel` dir

```ruby
task single: files.ext('.html')
multitask parallel: files.ext('.html')
```

# Rack

Minimalistic middleware / interfaces, that bridges between web servers, web frameworks, and web application into a single method call.

try building an app with Rack, you don't need a framework

```ruby
# config.ru
run do |env|
  [200, { "some_header" => "lalala"}, ["Hello World"]]
end
```

```sh
gem install rack
rackup # starts your default web server on 9292
# or specify alternative webserver, i.e. 'webrick'
rackup -s webrick
```

```sh
curl -I http://127.0.0.1:9292
```

# Active Support

[docs](https://guides.rubyonrails.org/active_support_core_extensions.html)

```sh
cd active_support
bundle install
bundle exec ruby bin/run
```

## Core

- `with_option`
- `try`
- `hash_with_indifferent_access`
- `presnece`
- `in?`
- to_json is better implemented than JSON gem

## 3 Extensions to Module

- [`delegate`](https://guides.rubyonrails.org/active_support_core_extensions.html#delegate) and `delegate_missing_to`

## 4 Extensions to Class

- `cattr_accessor`
- [`descendants`](https://guides.rubyonrails.org/active_support_core_extensions.html#descendants) and `subclasses`

## 5 Extensions to String

- `"".html_safe?`
- `squish`
- singularize, pluralize, camelize / underscore, titleize / dasherize, demodulize, deconstantize, parameterize, humanize, constantize

```ruby
"Hello World".remove(/Hello /) # => "World"

"Oh dear! Oh dear! I shall be late!".truncate(18, separator: ' ', omission: "🖖")) # =>  "Oh dear! Oh dear!🖖"
"Oh dear! Oh dear! I shall be late!".truncate_words(4)
# => "Oh dear! Oh dear!..."
o"foo".starts_with?("f") # => true
"foo".ends_with?("o")   # => true

<<HEREDOC.indent(2)
<<HEREDOC..strip_heredoc

'octopus'.pluralize
"equipment".singularize
"admin_user".camelize
"visual_effect".camelize(:lower) # => "visualEffect"
"visualEffect".underscore
"Admin::Hotel::ReservationUtils".demodulize # => "ReservationUtils"
"Admin::Hotel::ReservationUtils".deconstantize # => "Admin::Hotel"


"2010-07-27".to_date              # => Tue, 27 Jul 2010
"2010-07-27 23:37:00".to_time     # => 2010-07-27 23:37:00 +0200
"2010-07-27 23:37:00".to_datetime # => Tue, 27 Jul 2010 23:37:00 +0000

```

## Time

```ruby
1_235_551_234.to_fs(:phone, country_code: 61, area_code: true, extension: 555)
1_234_567_890.506.to_fs(:currency) # => $1,234,567,890.51
302.24398923423.to_fs(:percentage, precision: 5)
1_234_567_890_123.to_fs(:human_size) # => 1.12 TB
1_234_567_890.to_fs(:human) # => "1.23 Billion"
12_345_678.05.to_fs(:delimited, separator: ' ') # => 12,345,678 05
```

## Formatting

```ruby
1_235_551_234.to_fs(:phone, country_code: 61, area_code: true, extension: 555)
1_234_567_890.506.to_fs(:currency) # => $1,234,567,890.51
302.24398923423.to_fs(:percentage, precision: 5)
1_234_567_890_123.to_fs(:human_size) # => 1.12 TB
1_234_567_890.to_fs(:human) # => "1.23 Billion"
12_345_678.05.to_fs(:delimited, separator: ' ') # => 12,345,678 05
(Date.today..Date.tomorrow).to_fs(:db) # => "BETWEEN '2009-10-25' AND '2009-10-26'"
```

### Conversions

```ruby
%w(Earth Wind Fire).to_sentence # => "Earth, Wind, and Fire"
```

## 10 Extensions to Enumerable

- pluck
- pick
- `many?`
- `index_by`
- including / excluding
- exclude?

## 11 Extensions to Array

- extract

```ruby
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
odd_numbers = numbers.extract! { |number| number.odd? } # => [1, 3, 5, 7, 9]
numbers # => [0, 2, 4, 6, 8]
```

- similar to String/Enum methods, like `to`, `from`, `third`, `excluding`
- `.in_groups_of`

## 12 Extensions to Hash

- `deep_merge` / `merge` / `deep_dup`
- `except`
- `symbolize_keys` / `stringify_keys`

```ruby
{ a: 1, b: 1 }.merge(a: 0, c: 2)
{ a: 1, b: 2 }.except(:a) # => {:b=>2}

```

## 13 Extensions to Regexp

```ruby
%r{.}m.multiline? # => true
```

# ActiveRecord

ActiveRecord is essentially ActiveModel with persistence layer

```ruby
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'sample.sqlite3'
)
```

---

```ruby
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
    end
  end
end

CreateUsers.new.migrate(:up)
```

---

```ruby
class User < ActiveRecord::Base
  validates_presence_of :name, on: :create

  has_many :posts
end
```

----

- [ ] ActiveRecord
  - [ ] [basics](https://guides.rubyonrails.org/active_record_basics.html)
  - [ ] [migrations](https://guides.rubyonrails.org/active_record_migrations.html)
  - [ ] [validations](https://guides.rubyonrails.org/active_record_validations.html)
  - [ ] [callbacks](https://guides.rubyonrails.org/active_record_callbacks.html)
  - [ ] [Associations](https://guides.rubyonrails.org/association_basics.html)
  - [ ] [Query Interface](https://guides.rubyonrails.org/active_record_querying.html)

##  can't figure out what's causing a specific query in rails?

[look no further]([https://www.mayerdan.com/ruby/2022/06/27/rails-query-tracing](https://www.mayerdan.com/ruby/2022/06/27/rails-query-tracing)

```ruby
module ActiveRecord
  class LogSubscriber < ActiveSupport::LogSubscriber
    def sql(event)
      # NOTE: I add a global $ignore_query == false && if I need to say ignore all the factories or before/after spec specific queries to help
      # only find callers in application code.
      if /FROM "some_table" WHERE "some_condition"/.match?(event.payload[:sql])
        Rails.logger.info "SQL FOUND #{caller_locations[15...150]}" 
        binding.irb if ENV["QUERY_BINDING"]
        # or
        # require 'awesome_print' 
        # ap caller if ENV["QUERY_BINDING"]
      end
    end
  end
end

ActiveRecord::LogSubscriber.attach_to :active_record
```

# ActiveModel
