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

  trigger :print_balance do
    debtors = participant.compute_debtors
    creditors = participant.compute_creditors
    balance = debtors.merge(creditors).inject({}){|h, (k,v)| h.merge( k => {name: v[:name], amount: 0.0} ) }
    balance = balance.merge(debtors).merge(creditors) {|user, deb, cred| {name: deb[:name], amount: deb[:amount] - cred[:amount]} }
    puts "- #{participant.name} balance statement"
    print_report balance
  end

  trigger :print_payments_report do
    participant.show_report
  end

  def print_report participants
    participants.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
  end

  role :participant do
    def compute_debtors
      debtors = {}
      payments.each do |p|
        p.expense.shares.each do |s|
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
      Payment.where('user_id != ?', self.id).each do |p|
        p.expense.shares.each do |s|
          next if s.user != self
          creditors[p.user.id] ||= { name: "", amount: 0.0 }
          creditors[p.user.id][:name] = p.user.name
          creditors[p.user.id][:amount] += s.amount
        end
      end
      creditors
    end

    def show_report
      puts "- Payments related to #{self.name}"
      Payment.all.each do |p|
        p.expense.shares.each do |s|
          next if (self != p.user and self != s.user) or (p.user == s.user)
          puts "payer: %-8s receiver: %-8s %-10s $%5.2f" % [p.user.name, s.user.name, p.expense.description, s.amount]
        end
      end
    end
  end

end
