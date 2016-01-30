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
		# format_description(@description) + "event dates: " + format_dat
			format_description(@description).to_s + " " + 
			"Type: " + @type + " " +
			"Event Dates: " + format_date(start_date: @start_date, end_date: @end_date).to_s
	end
end
