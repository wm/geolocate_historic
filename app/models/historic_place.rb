class HistoricPlace < ActiveRecord::Base
  validates_uniqueness_of :title
  
  # Return the calc as a float rounded to 2 places.
  #
  def calc
    calc = read_attribute('calc')
    (calc.to_f * 10**2).round.to_f / 10**2 unless calc.nil?
  end
end
