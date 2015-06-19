class Contact
	attr_accessor :id, :first_name, :last_name, :email, :notes
	

	def initialize(first_name, last_name, email, notes)
		@first_name = first_name.capitalize
		@last_name = last_name.capitalize
		@email = email
		@notes = notes
	end

	def to_s
		# "#{id}:
		"#{first_name} #{last_name} <#{email}> -- Notes: #{notes}"
	end
end