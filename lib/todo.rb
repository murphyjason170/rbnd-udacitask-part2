require 'chronic'

class TodoItem
  include Listable
  attr_reader :description, :due, :priority
	
  # def initialize(description, options={})
  def initialize(type, description, options={})		
		@type = type
		@description = description    
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end
	def details
		format_description(@description) + 
		"Due: " + format_date(due_date: @due).to_s + " " + 
		"Type: " + @type.to_s + " " + 
		"Priority: " + format_priority(@priority).to_s
	end
end
