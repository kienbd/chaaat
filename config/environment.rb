# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Chaaaat::Application.initialize!

ANTISPAM_THRESHOLD = 10


require 'casclient'
require 'casclient/frameworks/rails/filter'

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "http://localhost:8888"
)

