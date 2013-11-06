#!/usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require './lib/cv_builder'
if ARGV.size < 1
  puts "usage: cvbuilder <config_file> <extension>"
  puts "\n"
  puts "\t <config_file> specifies the yaml file where the personality would be loaded from"
  puts "\t <extension> specifies the template, eg 'html' or 'tex'"
  exit 0
end
CvBuilder::Builder.new(config_file: ARGV[0], template: ARGV[1]).write
