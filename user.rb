require 'active_record'
require './db_schema'

class User < ActiveRecord::Base
  has_many :shares, inverse_of: :user
  has_many :payments, inverse_of: :user
  has_many :paid_expenses, :through => :payments, :source => :expense
  has_many :shared_expenses, :through => :shares, :source => :expense
end
