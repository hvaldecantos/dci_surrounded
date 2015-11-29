class User
  attr_reader :name
  def initialize name
    @name = name
  end
  def self.find id
  end
  def fed_up?
    # returns a random boolean value
    [true, false].sample
  end
  def say something
    puts something
  end
end
