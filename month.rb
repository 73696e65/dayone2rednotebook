#!/usr/bin/env ruby
# encoding: utf-8

class Month
	attr_accessor :day

	def initialize
		@day = {}
	end

	def add(day, timestamp, text)
		text.gsub!("'", "''")
		@day[day] ||= ""
		@day[day] << "**#{timestamp}**\n\n\n#{text}\n\n\n"
	end
end

