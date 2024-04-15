breaking down Ruby on Rails parts and demistifying it

- [ ] rake
- [ ] rack
- [ ] ActiveSupport
- [ ] hash_with_indifferent_access gotchas
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
