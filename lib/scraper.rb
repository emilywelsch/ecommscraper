# require "ecommscraper/version"
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/item.rb'


class Scraper
  attr_accessor :name, :url

  def self.scrape_items
    # items = [{:name=>"Ride and Rec Legging", :item_details=>"A paragraph of information.", :testimonials=>"A paragraph of information."}]
    items = []

    items << self.scrape_pixi

    items
  end

  def self.scrape_pixi
    doc = Nokogiri::HTML(open("https://www.pixicycling.com/"))
      # item = self.new
      item.name = doc.css('div h2')
      item.url = doc.css('a').attr('href').value

      item
    end
    # doc = Nokogiri::HTML(open("https://www.pixicycling.com/ride-recreation-34-legging/"))
    # item_details: = doc.css('div p')
    # doc = Nokogiri::HTML(open("https://www.pixicycling.com/testimonials/"))
    # testimonials: = doc.css('div.sqs-block-content')
    # binding.pry


  def self.scrape_item_details(profile_url)
    item_profile = "https://www.pixicycling.com/" + profile_url
    item_profile_page = Nokogiri::HTML(open(item_profile))

        item_profile_details = []
        items_page.css("").each do |attribute|
            tips = attribute.css('div._n5wk6ic').text
            item_profile_details << {tips: tips}
          end
        item_profile_details
  end


end
