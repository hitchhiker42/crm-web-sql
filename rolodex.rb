class Rolodex
  attr_reader :contacts
  @@id = 1000
  def initialize
    @contacts = []

  end

  def add_contact(contact)
    contact.id = @@id
    @contacts << contact
    @@id += 1
  end

  def find(contact_id)
    @contacts.find {|contact| contact.id == contact_id }
  end

  def remove_contact(contact)
    @contacts.delete(contact)
  end

  
end