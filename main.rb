require './user'
require './expense'
require './share'
require './payment'
require './register_shared_expense_payment'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"
pizza = Expense.create description: "Pizza"

RegisterSharedExpensePayment.new(payer: adele, participants: [adele, dan], expense_description: 'Pizza', total_amount: 14.20).start
RegisterSharedExpensePayment.new(payer: dan, participants: [adele, dan, alan], expense_description: 'Beer', total_amount: 10.0).start

p User.all
p Expense.all
p Share.all
p Payment.all
p adele.paid_expenses
p pizza.users
