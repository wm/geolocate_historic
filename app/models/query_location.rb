class QueryLocation < ActiveRecord::Base
  before_save :increment_query_count
  
  private
  
  def increment_query_count
    unless self.query_count.nil?
      self.query_count = self.query_count + 1 
    else
      self.query_count = 1
    end
  end
end
