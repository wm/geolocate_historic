class HistoricPlace < ActiveRecord::Base
  validates_uniqueness_of :title
  
  # Return the calc as a float rounded to 2 places.
  #
  def calc
    calc = read_attribute('calc')
    (calc.to_f * 10**2).round.to_f / 10**2 unless calc.nil?
  end
  
  # Returns the HistoricPlaces within distance of the lat,lng
  #
  def self.find_places_within(lat,lng,distance)
    distance_calculation = DistanceHelper.distance_calc(
         lat,lng,distance,table_name,'id,title,description,lat,lng')
    HistoricPlace.find_by_sql(distance_calculation)[0..20]
  end
  
end
