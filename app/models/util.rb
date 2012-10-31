module Util

	def self.list_models
		models = []
    Dir.foreach("#{Rails.root}/app/models") do |arquivo|
      models << arquivo.gsub('.rb', '').camelcase unless arquivo =~ /^\.|role|util|ability|comment/
    end
    models
	end
	
end