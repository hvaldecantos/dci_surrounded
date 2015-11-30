require 'surrounded'
require './user'
require './expense'

class Accounting
  extend Surrounded::Context

  keyword_initialize :creditor

  trigger :print_debtors do
    debtors = creditor.compute_debtors
    debtors.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
  end

  role :creditor do
    def compute_debtors
      debtors = {}
      paid_expenses.each do |e|
        e.shares.each do |s|
          next if s.user == self
          debtors[s.user.id] ||= { name: "", amount: 0.0 }
          debtors[s.user.id][:name] = s.user.name
          debtors[s.user.id][:amount] += s.amount
        end
      end
      debtors
    end
  end
end
