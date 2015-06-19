# This is like all the mathy/functional/'method' ey stuff
require_relative 'contact'
require_relative 'rolodex'
require 'sinatra'

$rolodex = Rolodex.new #global variable allows the server not to forget between requests
# $rolodex.add_contact(Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer"))
# $rolodex.add_contact(Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO"))
# $rolodex.add_contact(Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder"))

get '/' do
	@crm_app_name = "My CRM" # @ symbol has nothing to do with OOP. is preparing a variable for view
	erb :index # tells you to send off everything above it ot index.erb
	# ^ its also sending everything off to the client
end

get '/contacts' do 
	erb :contacts
end


get '/contacts/new' do
	erb :new_contact
end

get "/contacts/:id" do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

post "/contacts" do 
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:notes])
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')
end

put "/contacts/:id" do
  contact = $rolodex.find(params[:id].to_i)
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
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    $rolodex.remove_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
  end

