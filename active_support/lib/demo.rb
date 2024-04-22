require 'active_support'
require 'active_support/core_ext'

{a: ''}.a.presence || "default" # => "default"
{a: ''}.a          || "default" # => ""
{ key: 'value' }.with_indifferent_access['key'] # => 'value'
25.in?(30..50) # false
nil.try(:sum)

" \n  foo\n\r \t bar \n".squish # => "foo bar"
1_234_567_890_123.to_fs(:human_size) # => 1.12 TB
1_234_567_890.to_fs(:human) # => "1.23 Billion"
(Date.today..Date.tomorrow).to_fs(:db) # => "BETWEEN '2009-10-25' AND '2009-10-26'"

%w(Earth Wind Fire).to_sentence # => "Earth, Wind, and Fire"

[{a:1, b: 2}, {a:2}].pluck(:b) # [3, nil]

invoices.index_by(&:number)

odd_numbers = numbers.extract! { |number| number.odd? }

{ a: 1, b: 1 }.merge(a: 0, c: 2)


# `with_options`
class Account
  with_options dependent: :destroy do |assoc|
     assoc.has_many :customers
     assoc.has_many :products
     assoc.has_many :invoices
     assoc.has_many :expenses
  end
  # instead has_many :expenses, dependent: :destroy
end

class User < ApplicationRecord
  has_one :profile

  delegate :name, to: :profile
end
