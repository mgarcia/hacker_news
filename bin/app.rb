#!/usr/bin/env ruby

$:.unshift File.expand_path("../../lib", __FILE__)
require "hacker_news"


MAIL_FROM = 'guldenpt@gmail.com'
MAIL_TO   = 'guldenpt@gmail.com'

hackernews = HackerNews::HackerNews.new
hackernews.load_data
hackernews.send_email(from:MAIL_FROM, to:MAIL_TO) # send to localhost:25 by default


