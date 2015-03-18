require 'bundler/setup'
require 'sequel'
require 'csv'
require 'pry'
# require 'json'

class Init
	
	def initialize
		@test = true		
		@file_name = @table_name  = prompt_file_name
		@empty_table = should_empty_table
	end	

	def run
		if @file_name.nil? or @file_name.empty?
			p "Please add valid file name, all process has been stoped"
			return false
		end	
		connect_to_redshift
		truncate_table if @empty_table;
		read_file
		bulk_insert_to_db
	end

	def read_file
		@rows = []
		CSV.foreach("csv/#{@file_name}.csv", headers: true)  {|row| @rows << row.to_hash}
	end

	def bulk_insert_to_db
		@DB[:"#{@table_name}"].multi_insert(@rows)
	end

	def prompt_file_name
		p "Input File name: "
		gets.strip
	end

	def should_empty_table
		p "Press Y to empty table: "
		res = gets.strip || false
		(res and res.downcase == "y")
	end

	def connect_to_redshift
		@DB ||= Sequel.connect(ENV['REDSHIFT_CONNECTION'], options = {})		
	end

	def truncate_table
		@DB[:"#{@table_name}"].truncate
	end
		
end

init = Init.new
init.run