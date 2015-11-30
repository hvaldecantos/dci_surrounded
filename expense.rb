require 'active_record'
require './db_schema'

class Expense < ActiveRecord::Base
  has_many :shares, inverse_of: :expense
  has_one :payment, inverse_of: :expense
  has_one :user, :through => :payment
  has_many :users, :through => :shares
end
