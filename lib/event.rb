class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date

  def initialize(type, description, options={})
		@type = type
    @description = description
    @start_date = Date.parse(options[:start_date]) if options[:start_date]
    @end_date = Date.parse(options[:end_date]) if options[:end_date]
  end
  def details
			"Description:" + format_description(@description).to_s + " " + 
			"Type: " + @type + " " +
			"Event Dates: " + format_date(start_date: @start_date, end_date: @end_date).to_s
	end
  def details_for_table
			return {description: format_description(@description).to_s,
							type:	@type,
							event_dates: format_date(start_date: @start_date, end_date: @end_date).to_s
						 }			
	end
end
