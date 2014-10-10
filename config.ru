require 'rubygems'
require 'sinatra'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), 'app/router.rb')

run ConfessionBoard

