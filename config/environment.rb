# Load the Rails application.
require File.expand_path('../application', __FILE__)

my_date_formats = { :default => '%d/%m/%Y' }
Date::DATE_FORMATS.merge!(my_date_formats)
my_datetime_formats = { :default => '%d/%m/%Y %H:%M', :short => '%H:%M' }
Time::DATE_FORMATS.merge!(my_datetime_formats)


# Initialize the Rails application.
Jukebox::Application.initialize!
