require 'surrounded'

class User
  def self.find id
  end
end

class Employment
  extend Surrounded::Context

  initialize :employee, :boss

  role :boss
  role :employee
end

user1 = User.find(1)
user2 = User.find(2)
context = Employment.new(user1, user2)
