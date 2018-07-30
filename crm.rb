require_relative 'contact'

class CRM

  def initialize(name)
    @name = name
  end

  def main_menu
    while true # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Delete all entries'
    puts '[7] Exit'
    puts ""
    print 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then delete_all_entires
    when 7 then exit
    end
  end

  def add_new_contact
    print "Enter First Name: "
    first_name = gets.chomp

    print "Enter Last Name: "
    last_name = gets.chomp

    print "Enter Email Address: "
    email = gets.chomp

    print "Enter a Note: "
    note = gets.chomp

    contact = Contact.create(
      first_name: first_name,
      last_name: last_name,
      email: email,
      note: note
    )

    clear_src
  end

  def modify_existing_contact
    clear_src
    puts "Modify Menu".upcase
    puts "-------------------------"

    until @confirmation == 'y'
      print "Enter the ID of the contact to modify: "
      user_id = gets.to_i
      contact = Contact.find(user_id)

      puts ""
      p contact
      puts ""
      print "Is this the correct one? (Y/N): "
      @confirmation = gets.chomp.downcase
      puts ""
      clear_src
    end

    display_attribute_menu
    print "\nSelect the field you wish to search with: "
    @user_input = gets.to_i

    # "mapping" user input integer to actual attribute keys then save to a variable
    # but maybe should be an instance variable??
    attribute = convert_attribute_input

    if @user_input == 1
      puts "Error: cannot modify user id.".upcase
      puts "\nRestarting...".upcase
      sleep(2)
      clear_src
    else
      print "Enter the new value: "
      new_value = gets.chomp
      contact = Contact.update(contact.id, attribute => new_value)
      puts ""
      p contact
      puts "\nProcessing...".upcase
      sleep(2)
      clear_src
    end
  end

  def delete_contact
  end

  def display_all_contacts
    clear_src
    p Contact.all
    puts ""
  end

  def search_by_attribute
    clear_src
    puts "Search Menu".upcase
    puts "-------------------------"

    display_attribute_menu
    print "\nSelect the field you wish to search with: "
    @user_input = gets.to_i

    # "mapping" user input integer to actual attribute keys then save to a variable
    # but maybe should be an instance variable??
    attribute = convert_attribute_input

    print "Enter the value (case sensitive): "
    user_value = gets.chomp

    contact = Contact.find_by(attribute => user_value)

    puts ""
    p contact

    puts "\nProcessing...".upcase
    sleep(5)
    clear_src
  end

  def delete_all_entires
  end

  # clears terminal screen
  def clear_src
    puts "\e[H\e[2J"
  end

  def display_attribute_menu
    puts '[1] User ID'
    puts '[2] First Name'
    puts '[3] Last Name'
    puts '[4] Email Address'
    puts '[5] Notes'
  end

  # "mapping" user input integer to actual attribute keys then return the new "key"
  def convert_attribute_input
    case @user_input
    when 1 then attribute = 'id'
    when 2 then attribute = 'first_name'
    when 3 then attribute = 'last_name'
    when 4 then attribute = 'email'
    when 5 then attribute = 'note'
    end

    return attribute
  end
end

ec_app = CRM.new("Evillious Chronicles")
ec_app.main_menu

at_exit do
  ActiveRecord::Base.connection.close
end