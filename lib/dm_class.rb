require 'open-uri'
require 'nokogiri'

class DmClass 
  attr_accessor :title, :href, :description
  @@all = []

  def self.add_class(title, href, description)
    @@all << DmClass.new(title,href, description)
  end

  def initialize(title, href, description)
    @title = title
    @href = href
    @description = description
  end

  def self.all
    @@all
  end

  def print_description
    description.each { |desc| print "#{desc} " }
  end


   def self.list_class_titles
     all.each_with_index do |dm_class, index|
       puts "#{index + 1}. #{dm_class.title}"
     end
   end

  def self.scrape_calendar_page(url)
    print "Loading Des Moines Social Club Classes for this Month"
    page = Nokogiri::HTML(open url)
    page.xpath('//*/table/tbody/tr/td/ul/li/a').each do |node|
      self.add_class(node.xpath('text()').text, node['href'], get_description(node['href']))
    end
  end

  def self.get_description(url)
    print "."
    page = Nokogiri::HTML(open url)
    description = []
    page.xpath("//*/div/p/text()").each do |text|
      unless text.content.strip.gsub("\u00A0","").empty?  \
             || text.to_s.include?("Mulberry")            \
             || text.to_s.include?("515")
        description <<  text.text
      end
    end
    description
  end
end
