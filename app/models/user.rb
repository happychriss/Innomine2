class User < ApplicationRecord
  has_many :sales
  has_many :ideas

  def credit_print
    return (self.credit*100).round(0).to_s+" Credits"
  end

end
