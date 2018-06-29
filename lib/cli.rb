# require "ecommscraper/version"
require 'nokogiri'
require 'colorize'
require_relative '../lib/scraper.rb'
require_relative '../lib/item.rb'

class CLI
  # index_url = "https://www.afar.com/travel-guides/all-travel-guides"
  sites = ["Pixi Cycling", "Store 2", "Store 3", "Store 4", "Store 5", "Store 6"]

  def call
    puts "                "
    puts "***------------- ·÷±‡± Welcome to EcommScraper ±‡±÷· -------------***".colorize(:blue)
    puts "                "
    site_list
  end

  def site_list
    sites = ["Pixi Cycling", "Store 2", "Store 3", "Store 4", "Store 5", "All of the above"]
    puts "Which store would you like to shop? (Enter number or exit)".colorize(:blue)
      sites.each.with_index(1) do |site, i|
        puts "#{i}. #{site}"
      end
    puts "                "
    which_store?
  end

  def which_store?
    case user_input = gets.chomp
      when "exit"
        puts "See you next time!".colorize(:blue)
        exit
      when "1", "2", "3", "4", "5", "6"
        list(user_input)
      else
        puts "Invalid entry. Please try again.".colorize(:red)
        puts "                "
        site_list
      end
  end

  def list(user_input)
    sites = ["Pixi Cycling", "Store 2", "Store 3", "Store 4", "Store 5", "Store 6"]
    puts "Which items for sale from #{sites[user_input.to_i-1]} would you like to learn more about? (Enter number or exit)".colorize(:blue)
    make_items
    # add_attributes_to_items
    display_items
  end

  def make_items
    items_array = Scraper.scrape_items
    # Item.create_item(items_array)
  end

  def add_attributes_to_items
    Item.all.each do |item|
      attributes = Scraper.scrape_item_details(item.url)
      item.add_item_attributes(attributes_hash)
    end
  end

  def display_items
    Item.all.each.with_index(1) do |item, i|
      puts "#{i}. #{item.location}"
      end
    puts "                "
    # item_selector
  end

  def item_selector
    puts "Which travel item would you like to learn more about? (Enter a number or exit)".colorize(:cyan)
    user_input = gets.chomp
    if user_input == "exit"
      puts "See you on your next adventure!".colorize(:blue)
      exit
    elsif
      !user_input.to_i.between?(0, Item.all.count)
      puts "Invalid entry. Please try again.".colorize(:red)
      item_selector
    end
    display_details(user_input)
  end

  def display_details(user_input)
    item = Item.all[user_input.to_i-1]
    puts "                     "
    puts "Okay, let's explore the travel item you picked in #{item.location}.".colorize(:blue)
    puts "                     "
    puts ">>>>---------------- Your Essential #{item.name} Travel Guide ----------------->"
    puts "                     "
    puts "The gist: "
    puts "#{item.gist}"
    puts "                     "
    puts "When to visit: "
    puts "#{item.time}"
    puts "                     "
    puts "Getting around: "
    puts "#{item.transportation}"
    puts "                     "
    puts "Can't miss: "
    puts "#{item.cant_miss}"
    puts "                     "
    puts "Food & drink: "
    puts "#{item.food}"
    puts "                     "
    puts "Culture: "
    puts "#{item.culture}"
    puts "                     "
    puts "What the locals know: "
    puts "#{item.local_knowledge}"
    puts "                     "
    puts "Local resources: "
    puts "#{item.resources}"
    puts "                     "
    puts "For more information on this travel item, visit www.afar.com/travel-guides/#{item.url}."
    puts "                     "
    list_again?
  end

  def list_again?
    puts "Would you like to return to the list of travel items in #{item.continents[user_input.to_i-1]}? (Please enter yes or no)".colorize(:cyan)
    user_input = gets.chomp
    if user_input == "yes"
      puts "                     "
      list
    elsif user_input == "no"
      exit # INSTEAD OF EXIT ASK IF THEY WANT TO GO TO continent_list
    else
      puts "Sorry, I didn't understand that entry.".colorize(:red)
      list_again?
    end
  end

end
