require 'surrounded'
require './user'
require './expense'

class RegisterPayment
  extend Surrounded::Context

  keyword_initialize :payer, :participants, :receiver, :expense_description, :total_amount

  def initialize opts
    opts[:participants] ||= ""
    opts[:expense_description] ||= ""
    opts[:receiver] ||= ""
    map_roles(payer: opts[:payer], participants: opts[:participants], expense_description: opts[:expense_description], total_amount: opts[:total_amount], receiver: opts[:receiver])
  end

  trigger :make_shared_expense_payment do
    expense = payer.create_expense
    participants.split expense
    payer.register_payment expense
  end

  trigger :payback do
    map_roles(participants: [receiver].flatten, expense_description: "Payback")
    make_shared_expense_payment
  end

  role :payer do
    def create_expense
      expense = Expense.create(description: expense_description)
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
