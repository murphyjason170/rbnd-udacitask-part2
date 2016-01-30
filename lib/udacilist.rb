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
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
			@items.each_with_index do |item, position|
				puts "#{position + 1}) #{item.details}" 
			end
		end
	def filter(item_type)
		rows = []   
		@items.each_with_index do |item, position|
			rows << [position + 1, item.details] if (item.details).match("Type: #{item_type}")
		end
		table = Terminal::Table.new  :title => @title, :headings => ['Item #', 'Item Info'], :rows => rows
		puts table		
	end
  def all_professional_looking_table				
		rows = []   
		table = Terminal::Table.new :title => @title, :headings => ['Description', 'something'], :rows => rows		
		@items.each_with_index do |item, position|
			row_hash = item.details_for_table							
			rows << 
			[(position + 1).to_s.colorize(:magenta), 
				row_hash[:description].colorize(:green), 
				row_hash[:type].colorize(:cyan), 
				(row_hash[:event_dates] || row_hash[:due]),
				row_hash[:priority],
				row_hash[:site_name]
			]			
			table.headings = ['Item #'.colorize(:magenta), 'Description'.colorize(:green), 'Type'.colorize(:cyan), 'Dates', 'Priority', 'Site Name']
			table.rows = rows
		end
		puts table		
  end
end
