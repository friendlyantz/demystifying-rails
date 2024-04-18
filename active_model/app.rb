require 'active_model'

class Lala
  include ActiveModel::API

  attr_accessor :greeting

  validates :greeting, presence: true

  include ActiveModel::AttributeMethods
  attribute_method_prefix 'reset_'
  attribute_method_suffix '_highest?'
  define_attribute_methods 'greeting'

  def reset_attribute(attribute)
    send("#{attribute}=", 'Hey!')
  end

  extend ActiveModel::Callbacks
  define_model_callbacks :greet
  after_greet :say_bye

  def greet
    run_callbacks(:greet) { puts greeting }
  end

  def say_bye
    puts 'Bye!'
  end
end

l = Lala.new(greeting: 'Hello')

binding.irb
