class Idea < ApplicationRecord
  belongs_to :competition
  has_one :market, dependent: :destroy
  has_one :user
  after_create :add_market


  def shares_per_user(user_id)
    self.market.sales.where(:user_id => user_id).sum(:share)
  end

  private

  def add_market
    self.market=Market.create
  end



end
