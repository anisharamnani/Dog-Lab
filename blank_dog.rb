require 'mysql2'
require 'debugger'

class Dog 
	attr_accessor :name, :color, :id


	@@db = Mysql2::Client.new(
  :host => '127.0.0.1',
  :username => 'student',
  :password => 'mypass',
  :database => 'wizards',
  )

  def self.db
    @@db 
  end 

  def db 
    @@db 
  end 

	def initialize name, color
		@name = name 
		@color = color 
	end 

  def self.find id
  	results = db.query("
  		SELECT * 
  		FROM dogs 
  		WHERE id = #{id}
  		")
  	if results.first.nil?
  		"whimper"
  	else
  		self.new_from_db(results.first)
  	end 
  end 

  def insert  
  	self.db.query("
  		INSERT INTO dogs (name, color)
  		values ('#{self.name},' '#{self.color}')
  		")
  end 

  #what about the id
  def self.new_from_db row
  	dog = Dog.new(row["name"], row["color"])
  	dog.id = row["id"]
  	dog  
  end 

  def self.find_name name 
  	self.db.query("
  		SELECT * 
  		FROM dogs 
  		WHERE name = '#{name}'
  		")
		if results.first.nil?
  		"whimper"
  	else
  		self.new_from_db(results.first)
  	end 
  end 

  def wrap_results results 
  	dogs = []
  	results.each do |dog|
  		dogs << self.new_from_db(dog)
  	end 
  	dogs
  end 

  def update 
  	 self.db.query("
  		UPDATE dogs 
  		SET name = '#{self.name}', '#{self.color}'
  		where id = #{self.id}
  		")
  end 

  def mark_as_saved!
  	self.id = self.db.last_id if self.db.last_id > 0 
  end 

  def saved? 
  	if self.id.nil? 
  		return false
  	else
  		return true
  	end 

  def save 
  	self.saved ? self.update : self.insert
  end 

  def ==(other_dog)
  	self.id == other_dog.id
  end 


  def self.find_color
    self.db.query("
      SELECT * 
      FROM dogs 
      WHERE name = '#{color}'
      ")
    if results.first.nil?
      "whimper"
    else
      self.new_from_db(results.first)
    end 
  end 

end 

