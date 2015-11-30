require 'surrounded'
require './user'
require './expense'

class Accounting
  extend Surrounded::Context

  keyword_initialize :participant

  trigger :print_creditors do
    creditors = participant.compute_creditors
    print_report creditors
  end

  trigger :print_debtors do
    debtors = participant.compute_debtors
    print_report debtors
  end

  def print_report participants
    participants.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
  end

  role :participant do
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

    def compute_creditors
      creditors = {}
      shared_expenses.each do |e|
        next if e.user == self
        creditors[e.user.id] ||= { name: "", amount: 0.0 }
        creditors[e.user.id][:name] = e.user.name
        creditors[e.user.id][:amount] += e.shares.select{ |share| share.user == self }.first.amount
      end
      creditors
    end
  end

end
