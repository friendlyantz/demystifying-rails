module Extentions
  class User
    attr_accessor :first_name

    require 'active_support/core_ext'
    alias_attribute :name, :first_name
  end

  def alias_attribute
    puts 'Alias attribute'.red
    user = User.new
    user.first_name = 'John'
    puts user.name.green
    puts Extentions.module_parents
  end

  class A
    class_attribute :x, instance_writer: false, instance_reader: false, default: 'my'
  end

  class B < A; end

  class C < B; end

  def class_attribute_check
    puts 'Class attribute check'.red
    puts  B.x # => "my"
    A.x = :a
    puts  B.x # => :a
    puts  C.x # => :a

    B.x = :b
    puts  A.x # => :a
    puts  C.x # => :b

    C.x = :c
    puts  A.x # => :a
    puts  B.x # => :b
    puts  C.x # => :c
  end

  class SomeClass
    cattr_accessor :lala, default: 'ladida'
  end

  def cattr_accessor_check
    puts 'Cattr accessor check'.red
    puts SomeClass.lala
    SomeClass.lala = 'lala'
    puts SomeClass.lala
  end

  def html_safe_check
    puts 'Html safe check'.red
    require 'active_support/core_ext'
    puts 'Hello, <b>World</b>!'.html_safe?
    puts 'Hello, <b>World</b>!'.html_safe
    puts 'Hello&'.html_safe?
    puts 'Hello&'.html_safe
  end

  def time_check
    puts 'Time check'.red
    require 'active_support/core_ext'
    puts 1.day.from_now

    puts '2010-07-27 23:42:00'.to_time(:utc)   # => 2010-07-27 23:42:00 UTC
    puts '2010-07-27 23:42:00'.to_time(:local) # => 2010-07-27 23:42:00 +1000
    puts '2010-07-27 23:42:00'.to_time(:iso8601)
    puts 2.years.from_now
  end

  def formatting_check
    puts 1_235_551_234.to_fs(:phone, country_code: 61, area_code: true, extension: 555)
    puts 1_234_567_890.506.to_fs(:currency) # => $1,234,567,890.51
    puts 302.24398923423.to_fs(:percentage, precision: 5)
    puts 1_234_567_890_123.to_fs(:human_size) # => 1.12 TB
    puts 1_234_567_890.to_fs(:human) # => "1.23 Billion"
    puts 12_345_678.05.to_fs(:delimited, separator: ' ') # => 12,345,678 05

    puts %w[Earth Wind Fire].to_sentence # => "Earth, Wind, and Fire"
    puts (Date.today..Date.tomorrow).to_fs(:db) # => "BETWEEN '2009-10-25' AND '2009-10-26'"
  end

  def index_check
    puts [
      OpenStruct.new(a: 9, b: 2),
      OpenStruct.new(a: 2, b: 3),
      OpenStruct.new(a: 3, b: 4)
    ].index_by(&:a)
      .to_s.green
  end

  def extracting_check
    puts 'Extracting check'.red
    p numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    p odd_numbers = numbers.extract! { |number| number.odd? } # => [1, 3, 5, 7, 9]
    p numbers # => [0, 2, 4, 6, 8]
  end
end
