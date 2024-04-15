breaking down Ruby on Rails parts and demistifying it

- [ ] rake
- [ ] rack
- [x] ActiveSupport
- [x] hash_with_indifferent_access gotchas
- [ ] ActiveRecord
- [ ] ActiveModel
- [ ] ActiveMailer - running as standalone mailer
- [ ] ActiveJob
- [ ] others are too intertwined dependencies on the rest of rails to run individually: ActionCable, ActionVeiew, ActionController - these are better run inside rails
- [ ] DSLs in rails/ruby - RSpec, Routes
- [ ] Routes: sinatra/hanami/Roda better for
- [ ] templates: ERB
- [ ] dissecting-rails book/site

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
   puts 1_235_551_234.to_fs(:phone, country_code: 61, area_code: true, extension: 555)
    puts 1_234_567_890.506.to_fs(:currency) # => $1,234,567,890.51
    puts 302.24398923423.to_fs(:percentage, precision: 5)
    puts 1_234_567_890_123.to_fs(:human_size) # => 1.12 TB
    puts 1_234_567_890.to_fs(:human) # => "1.23 Billion"
    puts 12_345_678.05.to_fs(:delimited, separator: ' ') # => 12,345,678 05
```

## Formatting

```ruby
   puts 1_235_551_234.to_fs(:phone, country_code: 61, area_code: true, extension: 555)
    puts 1_234_567_890.506.to_fs(:currency) # => $1,234,567,890.51
    puts 302.24398923423.to_fs(:percentage, precision: 5)
    puts 1_234_567_890_123.to_fs(:human_size) # => 1.12 TB
    puts 1_234_567_890.to_fs(:human) # => "1.23 Billion"
    puts 12_345_678.05.to_fs(:delimited, separator: ' ') # => 12,345,678 05
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
