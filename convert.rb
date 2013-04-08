#!/usr/bin/env ruby
# encoding: utf-8

# Note: works without photos
# Version 0.01

dayone_dir = ARGV[0]
output_dir = ARGV[1]

unless ARGV[0] and ARGV[1]
  puts "syntax: #{$0} <dayone_import_dir> <rednotebook_output_dir>" ; exit
end


