class UdaciList	
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
	
    # @items.push TodoItem.new(description, options) if type == "todo"
    # @items.push EventItem.new(description, options) if type == "event"
    # @items.push LinkItem.new(description, options) if type == "link"
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
   puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|		  
    #  puts "#{position + 1}) #{item.details}"
    puts "#{position + 1}) #{item.details}" if (item.details).match("Type: #{item_type}")
    end	
	end
end
