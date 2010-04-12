class QueryLocation < ActiveRecord::Base
  before_save :increment_query_count
  
  def self.find_near(lat,lng,distance)
    distance_calculation = DistanceHelper.distance_calc(
         lat,lng,distance,table_name,'id,lat,lng,query_count')
    QueryLocation.find_by_sql(distance_calculation)[0]
  end
  
  private
  
  def increment_query_count
    unless self.query_count.nil?
      self.query_count = self.query_count + 1 
    else
      self.query_count = 1
    end
  end
end
