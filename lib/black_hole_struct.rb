# *BlackHoleStruct* is a data structure similar to an OpenStruct, that allows
# infinite chaining of attributes or [autovivification](https://en.wikipedia.org/wiki/Autovivification).
class BlackHoleStruct
  # Current version
  VERSION = "0.1.2"

  # BlackHoleStruct can be optionally initialized with a Hash
  # @param [Hash] hash Initialize with a hash
  # @return [BlackHoleStruct]
  def initialize(hash = {})
    raise ArgumentError, "Argument should be a Hash" unless hash.is_a?(Hash)

    @table = {}
    hash.each do |key, value|
      value = self.class.new(value) if value.is_a?(Hash)
      @table[key.to_sym] = value
    end
  end

  # Retrieves the value object corresponding to the key symbol.
  # @param [Symbol] key
  # @return the value object or a BlackHoleStruct if nothing was found
  def [](key)
    method_missing(key)
  end

  # Associates the value given by value with the key given by key.
  # @param [Symbol] key
  # @param value
  # @return the value
  def []=(key, value)
    method_missing("#{key}=", value)
  end

  # Two BlackHoleStruct are equal if they each contain the same number of keys
  # and if each key-value pair is equal to the corresponding elements in
  # the other BlackHoleStruct.
  # @param [BlackHoleStruct]
  # @return [Boolean]
  def ==(other)
    other.is_a?(self.class) && self.to_h == other.to_h
  end
  alias :eql? :==

  # Deletes the key-value pair and returns the value from hsh whose key is equal to key.
  # If the key is not found, returns an instance of BlackHoleStruct.
  # @param [Symbol] key
  def delete_field(key)
    @table[key.to_sym] = self.class.new
  end

  # Calls block once for each key in hsh, passing the key-value pair as parameters.
  # if no block is given, an Enumerator is returned instead.
  # @yield [key, value]
  def each_pair
    @table.each_pair
  end

  # Returns a new hash with self and other_hash merged.
  # @param [Hash] other_hash
  # @return the final hash
  def merge(other_hash)
    self.dup.merge!(other_hash)
  end

  # Same as merge, but modifies self.
  # @param [Hash] other_hash
  # @return the final hash
  def merge!(other_hash)
    # no deep merge
    @table = self.to_h.merge!(other_hash)
    self
  end
  alias :update :merge!

  # Returns a new hash with self and other_hash merged recursively.
  # It only merges Hash recursively.
  # @param [Hash] other_hash
  # @return the final hash
  def deep_merge(other_hash)
    self.dup.deep_merge!(other_hash)
  end

  # Same as deep_merge, but modifies self.
  # @param [Hash] other_hash
  # @return the final hash
  def deep_merge!(other_hash)
    other_hash.each_pair do |current_key, other_value|
      this_value = @table[current_key.to_sym]

      if (this_value.is_a?(Hash) || this_value.is_a?(self.class)) &&
        (other_value.is_a?(Hash) || other_value.is_a?(self.class))
        @table[current_key.to_sym] = this_value.deep_merge(other_value)
      else
        @table[current_key.to_sym] = other_value
      end
    end

    self
  end

  # Converts self to the hash
  # @return [Hash]
  def to_h
    hash = {}
    @table.each do |key, value|
      hash[key] = value.is_a?(self.class) ? value.to_h : value
    end
    hash
  end

  # Return the contents of this instance as a string.
  # @return [String]
  def inspect
    "#<#{self.class}"
      .concat(@table.map { |k, v| " :#{k}=#{v.inspect}" }.join(" "))
      .concat(">")
  end
  alias :to_s :inspect

  private

  def initialize_copy(other)
    super
    @table = @table.clone
  end

  def method_missing(name, *args)
    if @table[name.to_sym]
      @table[name.to_sym]
    else
      if name[-1] == "="
        @table[name[0..-2].to_sym] = args.first
      else
        @table[name.to_sym] = self.class.new
      end
    end
  end
end
