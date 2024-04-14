# frozen_string_literal: true

class App
  def initialize
    hash_with_indifferent_access
  end

  def hash_with_indifferent_access
    puts "Hash with indifferent access".red
    require "active_support/core_ext/hash/indifferent_access"
    hash = {a: "hash_key"}.with_indifferent_access
    puts hash["a"]
    puts hash[:a]

    try = {a: "key not founfd"}["a"] # => 1w
    puts try
    try_2 = {a: "value"}[:a] # => 1w
    puts try_2
    result = {a: "another value"}.with_indifferent_access["a"]
    puts result
  end
end
