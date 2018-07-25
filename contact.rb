class Contact
  @@contacts = []
  @@id = 1

  # This method should initialize the contact's attributes
  def initialize(first_name, last_name, email, note = 'N/A')
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
    @id = @@id
    @@id += 1 # this way the next contact will get a different id
  end

  # setting up atrribute accessors
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note

  # This method should call the initializer,
  # store the newly created contact, and then return it
  def self.create(first_name, last_name, email, note)
    new_contact = self.new(first_name, last_name, email, note)
    @@contacts << new_contact
    return new_contact
  end

  # This method should return all of the existing contacts
  def self.all
    return @@contacts
  end

  # This method should accept an id as an argument
  # and return the contact who has that id
  def self.find(id)
    @@contacts.each do |contact|
      if contact.id == id
        return contact
      else
        puts "Error: ID does not exists".upcase
      end
    end
  end

  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  def update(attribute, value)
    case attribute
    when 1
      @first_name = value.capitalize
    when 2
      @last_name = value.capitalize
    when 3
      @email = value
    when 4
      @note = value.capitalize
    end
  end

  # This method should work similarly to the find method above
  # but it should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty
  def self.find_by(attribute, value)
    case attribute
    # when 1 # search by id
    #   @@contacts.each do |contact|
    #     if contact.id == value
    #       return contact
    #     end
    #   end
  when 1 # search by first name
      @@contacts.each do |contact|
        if contact.first_name.downcase == value
          return contact
        end
      end
    when 2 # search by last name
      @@contacts.each do |contact|
        if contact.last_name.downcase == value
          return contact
        end
      end
    when 3 # search by email
      @@contacts.each do |contact|
        if contact.email.downcase == value
          return contact
        end
      end
    when 4 # unable to search by notes
      puts "ERROR: Field too broad".upcase
    when 5 # return to main
      return
    end
  end

  # This method should delete all of the contacts
  def self.delete_all
    @@contacts.clear
  end

  def full_name
    "#{@first_name} #{last_name}" # use readers if it exists, but can mix and match
  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  def delete
    @@contacts.delete(self)
  end

  # Feel free to add other methods here, if you need them.
end
