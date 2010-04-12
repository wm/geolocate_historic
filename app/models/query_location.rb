class QueryLocation < ActiveRecord::Base
  validate :uniqueness_witin_radius
  
  def uniqueness_witin_radius
    radius = 0.5
    distance_calculation = DistanceHelper.distance_calc(
        lat,lng,radius,QueryLocation.table_name,'lat,lng')
    qls = QueryLocation.find_by_sql(distance_calculation)      
    errors.add('Location',"must be unique to a #{radius} mile radius.") unless qls.empty?
  end
end
