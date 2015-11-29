require 'surrounded'
require './user'

class EmploymentContext
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
