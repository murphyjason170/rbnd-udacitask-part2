require 'chronic'
require 'colorize'

class TodoItem
  include Listable
  attr_reader :description, :due, :priority
	
  def initialize(type, description, options={})		
		@type = type
		@description = description    
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end
	def details
		"Description: " + format_description(@description) + 
		"Type: " + @type.to_s + " " + 
		"Due: " + format_date(due_date: @due).to_s + " " + 
		"Priority: " + format_priority(@priority).to_s.colorize(:red)
	end
	def details_for_table
		return {
			description: format_description(@description).to_s,
			type:	@type,
			due: format_date(due_date: @due).to_s,
			priority: format_priority(@priority).to_s.colorize(:red)
		}			
	end

end
