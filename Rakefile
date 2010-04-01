# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

namespace :hpdata do
  require 'csv'
  
  desc "parse csv file into db"
  task :parse do
    `./script/runner lib/ne_csv_parser.rb './ne_landmarks.csv'`
  end
end
  