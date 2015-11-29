require './user'
require './expense'
require './share'
require './payment'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
pizza = Expense.create description: "Pizza"

Share.create user_id: adele.id, expense_id: pizza.id, amount: 7.10
Share.create user_id: dan.id, expense_id: pizza.id, amount: 7.10

Payment.create user_id: adele.id, expense_id: pizza.id
Payment.create user_id: adele.id, expense_id: pizza.id

p User.all
p Expense.all
p Share.all
p Payment.all
p adele.paid_expenses
p pizza.users
