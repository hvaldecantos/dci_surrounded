require './employment_context'
require './user'

user1 = User.new("Edward")
user2 = User.new("Bob")
context = EmploymentContext.new(employee: user1, boss: user2)
context.plan_weekend_work
