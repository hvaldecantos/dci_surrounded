require './user'
require './expense'

User.create name: "Adele"
Expense.create description: "Rent"

p User.all
p Expense.all
