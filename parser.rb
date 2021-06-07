require 'optparse'
require './table_builder'
require './csv_builder'

options = {}

parser = OptionParser.new do |parser|
  parser.on("-y", "--year YEAR", "Filter by Year") { |year| options[:year] = year }
  parser.on("-t", "--team NAME", "Filter by Team name") { |team| options[:team] = team }
end
parser.parse!

TableBuilder.new(CsvBuilder.new.call(options)).print