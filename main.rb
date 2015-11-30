require './user'
require './expense'
require './share'
require './payment'
require './register_shared_expense_payment'
require './accounting'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

RegisterSharedExpensePayment.new(payer: adele, participants: [adele, dan], expense_description: 'Pizza', total_amount: 14.20).start
RegisterSharedExpensePayment.new(payer: dan, participants: [adele, dan, alan], expense_description: 'Beer', total_amount: 10.0).start
RegisterSharedExpensePayment.new(payer: dan, participants: [adele, dan, alan], expense_description: 'Beer', total_amount: 10.0).start
RegisterSharedExpensePayment.new(payer: alan, participants: [adele, dan, alan], expense_description: 'Ticket', total_amount: 30.0).start
RegisterSharedExpensePayment.new(payer: alan, participants: [adele, dan, alan], expense_description: 'Taxy ride', total_amount: 23.0).start

Accounting.new(participant: adele).print_balance
Accounting.new(participant: dan).print_balance
Accounting.new(participant: alan).print_balance

RegisterSharedExpensePayment.new(payer: dan, participants: [adele], expense_description: 'Payback', total_amount: 0.44).start
RegisterSharedExpensePayment.new(payer: dan, participants: [alan], expense_description: 'Payback', total_amount: 11.01).start

Accounting.new(participant: adele).print_balance
Accounting.new(participant: dan).print_balance
Accounting.new(participant: alan).print_balance

Accounting.new(participant: adele).print_payments_report
