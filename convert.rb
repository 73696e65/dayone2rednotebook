#!/usr/bin/env ruby
# encoding: utf-8

=begin
Note: works with date and text entries only
Version 0.01
=end

$:.unshift(File.expand_path(File.dirname(__FILE__)))

require 'nokogiri'
require 'date'

require 'month'

dayone_dir = ARGV[0]
output_dir = ARGV[1]

db = {}

unless dayone_dir and output_dir
	puts "syntax: #{$0} <dayone_import_dir> <rednotebook_output_dir>" ; exit
end

Dir["#{dayone_dir}/*"].each do |f|
	xml  = Nokogiri::XML(File.open(f))

	i_date = xml.xpath("/plist/dict/date").text

	year_month = DateTime.parse(i_date).strftime("%Y-%m")
	day = DateTime.parse(i_date).strftime("%-d")
	timestamp = DateTime.parse(i_date).strftime("%A, %m/%d/%Y %r")

	text = xml.xpath("/plist/dict/string").first.text
	
	db[year_month] ||= Month.new
	db[year_month].add(day, timestamp, text)
end

db.each do |key, month|
	File.open("#{output_dir}/#{key}.txt", "w") do |f|
		month.day.each do |day_nr, entry|
			f.puts "#{day_nr}: {text: '#{entry}'}"
		end
	end
end
