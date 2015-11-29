require 'surrounded'

class User
  def self.find id
  end
end

class Employment
  extend Surrounded::Context

  keyword_initialize :employee, :boss

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

user1 = User.find(1)
user2 = User.find(2)
context = Employment.new(employee: user1, boss: user2)
