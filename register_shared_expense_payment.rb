require 'surrounded'
require './user'
require './expense'

class RegisterSharedExpensePayment
  extend Surrounded::Context

  keyword_initialize :payer, :participants, :expense_description, :total_amount

  trigger :start do
    expense = payer.create_expense
    participants.split expense
    payer.register_payment expense
  end

  role :payer do
    def create_expense
      expense = Expense.find_or_create_by(description: expense_description)
    end
    def register_payment expense
      payments.create(expense: expense)
    end
  end

  role :participants do
    def split expense
      partial_amount = total_amount / size
      each do |participant|
        participant.shares.create(expense: expense, amount: partial_amount)
      end
    end
  end
end
