
class Market < ApplicationRecord
  has_many :sales,  dependent: :destroy
  belongs_to :idea
  after_create :default_values


  def price_print
    return (self.price*100).round(0).to_s+" Credits"
  end

  def buy(count = 1,user_id)
    ActiveRecord::Base.transaction do

      ## Update Credits

      user=User.find(user_id)
      user.credit=user.credit-cost_function(self.idea.competition,self,count)
      user.save!

      ## Update market sales
      self.q0 = q1
      self.q1 = self.q1 + count
      self.save!
      self.reload

      ## Update prices of all markets
      update_market_prices(self.idea.competition)
      self.save!
      self.reload

      ## Creates Sales
      sales =self.sales.new(
          price: self.price,
          q0: self.q0,
          q1: self.q1,
          user_id: user_id,
          share:1*count)
      sales.save!


    end
  end

  def tendency
    s=self.sales.order(id: :desc).first(2)
    if s.count<2
      :equal
    elsif
      s[0].price>s[1].price
      :up
    else
      :down
    end
  end

  private

  def cost_function(competition, market_buy,count=0)

  # C = b * ln(eq1/b+eq2/b)
  # C(q1*,q2*) – C(q1,q2)

    c=competition.reload
    b=c.market_velocity_b.to_f
    all_markets=c.markets
    non_created_markets=c.max_markets - all_markets.count

    efunc_c0=0
    efunc_c1=0

    all_markets.each do |m|

        efunc_c0=efunc_c0+Math.exp((m.q1.to_f)/b.to_f).to_f

        if market_buy==m
          efunc_c1=efunc_c1+Math.exp((m.q1.to_f+count)/b.to_f).to_f
        else
          efunc_c1=efunc_c1+Math.exp((m.q1.to_f)/b.to_f).to_f
        end
    end

    c0=b*Math.log(efunc_c0+non_created_markets)
    c1=b*Math.log(efunc_c1+non_created_markets)

    return c1-c0

  end

  def update_market_prices(competition)
    b=competition.market_velocity_b.to_f;
    all_markets=self.idea.competition.markets
    denominator=0

    # all open markets
    all_markets.each do |m|
      denominator=denominator+Math.exp(m.q1.to_f/b)
    end

    # also add for markets not yet opened, based on max markets
    # for closed market we assume q1 is 0, hence exp(q1/b)=1

    non_created_markets=self.idea.competition.max_markets - all_markets.count
    denominator=denominator+non_created_markets

    all_markets.each do |m|
      numerator=Math.exp(m.q1.to_f/b)
      m.price=numerator/denominator
      m.save!
    end

  end

  def calc_denominator

  end

  def default_values
    self.q0=0
    self.q1=0
    self.save!
    self.reload
    update_market_prices(self.idea.competition)
  end

end
