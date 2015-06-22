require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource	

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :notes, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

get "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

post "/contacts" do
  contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :notes => params[:notes]
  )
  redirect to('/contacts')
end

put "/contacts/:id" do
  contact = Contact.get(params[:id].to_i)
  puts params
  if contact
    contact.first_name = params[:first_name]
    contact.last_name = params[:last_name]
    contact.email = params[:email]
    contact.notes = params[:notes]
    puts $rolodex.contacts

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

 delete "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
  end