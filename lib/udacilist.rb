class UdaciList	
require 'terminal-table'
require 'colorize'
  attr_reader :title, :items

  def initialize(options={})
		if !options[:title]
			@title = "Untitled List"
		else	
			@title = options[:title]
		end
			@items = []
  end
  def add(type, description, options={})
    type = type.downcase
		raise UdaciListErrors::InvalidItemType, "'#{type}' is not a valid item." if type != "todo" and type != "event" and type != "link"
    @items.push TodoItem.new(type, description, options) if type == "todo"
    @items.push EventItem.new(type, description, options) if type == "event"
    @items.push LinkItem.new(type, description, options) if type == "link"	
  end
  def delete(index)		 
		raise UdaciListErrors::IndexExceedsListSize, "'#{index}' is not a valid index." if index > @items.size			
		@items.delete_at(index - 1)		
  end
	def all	
		title_printer
		@items.each_with_index do |item, position|
			puts "#{position + 1}) #{item.details}" 
		end
	end
	def title_printer
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length	
	end  
	def filter(item_type)
		title_printer
		@items.each_with_index do |item, position|
			puts "#{position + 1}) #{item.details}" if (item.details).match("Type: #{item_type}")
		end
	end
	def filter_by_priority(user_specified_priority)
		title_printer
		priority = "P3" if user_specified_priority == "high"
		priority = "P2" if user_specified_priority == "medium"
		priority = "P1" if user_specified_priority == "low"
		@items.each_with_index do |item, position|
			puts "#{position + 1}) #{item.details}" if (item.details).match("#{priority}")
		end
	end
  def all_professional_looking_table				
		rows = []   
		priority_color = "white"
		table = Terminal::Table.new :title => @title.colorize(:cyan), :rows => rows		
		@items.each_with_index do |item, position|
			row_hash = item.details_for_table
			priority_color = "red" if row_hash[:priority] == "P3"
			priority_color = "magenta" if row_hash[:priority] == "P2"
			priority_color = "blue" if row_hash[:priority] == "P1"			
			rows << [(position + 1).to_s.colorize(:magenta), row_hash[:description].colorize(:green), row_hash[:type].colorize(:cyan), (row_hash[:event_dates].to_s.colorize(:magenta) || row_hash[:due].to_s.colorize(:magenta)),row_hash[:priority].to_s.colorize(priority_color.to_s),row_hash[:site_name].to_s.colorize(:green)]			
		end
		table.headings = ['Item #', 'Description', 'Type', 'Dates', 'Priority', 'Site Name']
		table.rows = rows
		puts table		
  end
end
