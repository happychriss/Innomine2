class Competition < ApplicationRecord
  has_many :ideas, dependent: :destroy
  has_many :markets, through: :ideas



  def ideas_by_marketprice
    self.ideas.includes('market').order('markets.price desc')
  end




  def maxwins_per_user(user_id)
    maxwin=0
    self.ideas_by_marketprice.each_with_index do |idea,index|
      maxwin += idea.shares_per_user(user_id)
      break if index==self.maxwins-1
    end
    return maxwin
end




end
