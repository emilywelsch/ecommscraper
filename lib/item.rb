# require "wanderlust/version"

class Item
  attr_accessor :name, :url

  @@all = []

  def initialize(item_hash)
    item_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self unless @@all.any? {|item| item.location == self.location} #change to .url once scraper is working
  end

  def self.all
    @@all
  end

  # def self.create_item(item_array)
  #   item_array.each do |item_hash|
  #     self.new(item_hash)
  #   end
  # end

  def add_item_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    check_attributes_for_nil
    self
  end

  def check_attributes_for_nil
  attributes = ["location", "gist", "time", "transportation", "cant_miss", "food", "culture", "local_knowledge", "resources", "url"]
  empty = [" ", "", nil]
    attributes.each do |var|
      if empty.any? { |e| self.send("#{var}") == e}
        self.send(("#{var}="), "N/A")
      end
    end
  end

end
