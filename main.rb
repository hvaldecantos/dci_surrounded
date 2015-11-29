require './user'
require './expense'
require './share'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
pizza = Expense.create description: "Pizza"

Share.create user_id: adele.id, expense_id: pizza.id, amount: 7.10
Share.create user_id: dan.id, expense_id: pizza.id, amount: 7.10

p User.all
p Expense.all
puts Share.all
