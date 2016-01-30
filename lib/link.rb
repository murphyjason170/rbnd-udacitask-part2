class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(type, url, options={})
		@type = type
		@description = url
    @site_name = options[:site_name]
  end
  def format_name
    @site_name ? @site_name : ""
  end
  def details
    "Description: " + format_description(@description) + 
		"Type: " + @type + " " +
		"Site Name: " + format_name
  end
	def details_for_table
		return {description: format_description(@description).to_s,
						type:	@type,
						site_name: format_name.to_s
					 }			
	end

end
