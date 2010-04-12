class DistanceHelper
  
  # Returns a string to be used by SQL for querying rows that are within the 
  # distance entered from the point entered compared with the lat, lng in the 
  # database row. 
  #
  # Returns a string of the form
  # SELECT attributes_str,distance from table WHERE distance <= distance
  #
  # Operates on the given table and groupes by the attributes also.
  #
  def self.distance_calc(lat,lng,distance,table,attributes_str)    
    # Note that pgSQL does not allow you to order by or group by a calculation alias
    # So I had to order by the actual calculation make it work cross platform.
    
    calc = "((ACOS(SIN(#{lat} * PI() / 180) * SIN(lat * PI() / 180) + "
    calc = calc + "COS(#{lat} * PI() / 180) * COS(lat * PI() / 180) * "
    calc = calc + "COS((#{lng} - lng) * PI() / 180)) * 180 / PI()) * 60 * 1.1515)" 
    sql = "SELECT #{attributes_str},#{calc} as calc FROM #{table} "
    #sql = sql + "GROUP BY id,title,lat,lng HAVING calc <= 2 ORDER BY calc"
    sql = sql + "GROUP BY #{attributes_str} HAVING #{calc} <= #{distance} ORDER BY calc"
  end
end