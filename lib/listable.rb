module Listable
	require 'colorize'

	def format_description(description)
		"#{description}".ljust(30)
  end
	def format_date(options = {})
		if options[:due_date]
			due = options[:due_date]			
			return due ? @due.strftime("%D") : "No due date" 
		end
		if options[:start_date] or options[:end_date] 		
			start_date = options[:start_date]
			end_date = options[:end_date]
			dates = start_date.strftime("%D") if start_date
			dates << " -- " + end_date.strftime("%D") if end_date
			dates = "N/A" if !dates
			return dates
		end
	end
	def format_priority(priority)
	  valid_priority = ["high", "medium", "low"]
		if !priority		
		elsif valid_priority.include?(priority) == false 
			raise UdaciListErrors::InvalidPriorityValue, "'#{priority}' is not a valid priority." 		
		else	
			value = "P3".colorize(:red) if priority == "high"
			value = "P2".colorize(:magenta) if priority == "medium"
			value = "P1".colorize(:green) if priority == "low"
			value = "P0".colorize(:blue) if !priority
			return value
		end
  end
end
