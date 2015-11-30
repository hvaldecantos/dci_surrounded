require './user'
require './expense'
require './share'
require './payment'
require './register_payment'
require './accounting'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

RegisterPayment.new(payer: adele, participants: [adele, dan], expense_description: 'Pizza', total_amount: 14.20).make_shared_expense_payment
RegisterPayment.new(payer: dan, participants: [adele, dan, alan], expense_description: 'Beer', total_amount: 10.0).make_shared_expense_payment
RegisterPayment.new(payer: dan, participants: [adele, dan, alan], expense_description: 'Beer', total_amount: 10.0).make_shared_expense_payment
RegisterPayment.new(payer: alan, participants: [adele, dan, alan], expense_description: 'Ticket', total_amount: 30.0).make_shared_expense_payment
RegisterPayment.new(payer: alan, participants: [adele, dan, alan], expense_description: 'Taxy ride', total_amount: 23.0).make_shared_expense_payment

Accounting.new(participant: adele).print_balance
Accounting.new(participant: dan).print_balance
Accounting.new(participant: alan).print_balance

RegisterPayment.new(payer: dan, receiver: adele, total_amount: 0.44).payback
RegisterPayment.new(payer: dan, receiver: alan, total_amount: 11.01).payback

Accounting.new(participant: adele).print_balance
Accounting.new(participant: dan).print_balance
Accounting.new(participant: alan).print_balance

Accounting.new(participant: dan).print_payments_report
