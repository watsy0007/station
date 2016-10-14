require 'watir'
require 'mechanize'

b= Watir::Browser.new :phantomjs
b.goto 'http://www.smartisan.com/#/shop'
page = Mechanize::Page.new(nil, {'content-type' => 'text/html'}, b.html, nil, Mechanize.new)
puts page.xpath('//ul[contains(@class, \'top-breadcrumb\')]/li/a')
