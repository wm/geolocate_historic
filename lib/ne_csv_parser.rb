require 'csv'

class NeCsvParser
  def self.csv_import(file)
    CSV.open(file,'r') do |row|
      HistoricPlace.create!(
        :lng => row[0],
        :lat => row[1],
        :title => row[2],
        :description => row[3]
      )
    end
  end
end

if ARGV.size == 1 && File.exists?(ARGV[0])
  NeCsvParser.csv_import(ARGV[0])
else
  puts "usage: #{$0} <file-path>"
  puts
end