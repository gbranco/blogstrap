# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PrimeiraApp::Application.initialize!
Encoding.default_external = "UTF-8"
ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port  => 25,
  :user_name  => "luiz.cezer@gmail.com",
  :password  => "@@batata8juvenal@@",
  :authentication  => :login
}
