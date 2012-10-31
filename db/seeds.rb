#coding : utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(:name => 'administrador', :situation => true)
Role.create(:name => 'moderador', :situation => true)

User.create(:name => 'Luiz Cezer', :email => 'lccezinha@gmail.com', :password => '123456', :situation => true, :role_id => Role.first.id)

categories = %w(Esportes Notícias Games Novidades Rails Ruby Desenvolvimento)
categories.each { |category| Category.create(:name => category, :situation => true) }




