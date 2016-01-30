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
    format_description(@description) + 
		"Type: " + @type + " " +
		"Site Name: " + format_name
  end
end
