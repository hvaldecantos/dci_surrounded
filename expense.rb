require 'active_record'
require './db_schema'

class Expense < ActiveRecord::Base
  has_many :shares, inverse_of: :expense
  has_many :payments, inverse_of: :expense
  has_many :users, :through => :payments
end
