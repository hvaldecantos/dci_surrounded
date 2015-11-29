require 'surrounded'

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

class Employment
  extend Surrounded::Context

  keyword_initialize :employee, :boss

  def plan_weekend_work
    employee.work_weekend
  end
  trigger :plan_weekend_work

  role :boss

  role :employee do
    def work_weekend
      if fed_up?
        quit
      else
        schedule_weekend_work
      end
    end

    def quit
      say("I'm sick of this place, #{boss.name}!")
      say("I quit!")
    end

    def schedule_weekend_work
      say("Saturday from 9am to 17pm...")
    end
  end
end

user1 = User.new("Edward")
user2 = User.new("Bob")
context = Employment.new(employee: user1, boss: user2)
context.plan_weekend_work
