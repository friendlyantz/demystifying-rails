require "active_support"

class App
  def initialize
    self.class
      .instance_methods(false)
      .each { |method| send method }
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

  def blank_check
    require "active_support/core_ext"
    puts "Blank check".red
    puts ["", " ", nil, [], {}].map(&:blank?)
  end

  def presence_check
    puts "Presence check".red
    os = OpenStruct.new(a: "")
    puts os.a || "default not returned as key is found but value is empty string"
    require "active_support/core_ext"
    puts os.a.presence || "default replacing empty string"
  end

  def duplicable_check
    puts "Duplicable check".red
    require "active_support/core_ext"
    puts({a: "hash"}.duplicable?)
    puts 1.method(:+).duplicable?
  end

  def deep_dup_check
    puts "Deep dup check".red
    puts "not deep".light_red
    array = ["string"]
    duplicate = array.dup

    # frozen string is not disabled
    duplicate.first.gsub!("string", "foo")

    puts array     # => ['string']
    puts duplicate # => ['foo']

    puts "deep".light_red
    array = ["string"]
    duplicate = array.deep_dup

    duplicate.first.gsub!("string", "foo")

    puts array     # => ['string']
    puts duplicate # => ['foo']
  end

  def try_check
    puts "Try check".red
    require "active_support/core_ext"
    puts nil.try(:to_s)
    puts 1.try(:to_s)
    puts 1.try { |i| i + 99 }
  end

  def acts_like_check
    puts "Acts like check".red
    require "active_support/core_ext"
    duck = OpenStruct.new
    duck.define_singleton_method(:acts_like_duck?) do
      puts "Quack!"
    end
    puts duck.acts_like?(:duck)
  end
end
