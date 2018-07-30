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

    # Contact.create(first_name, last_name, email, note)
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
    print "Enter the first name of the contact to update: "
    value = gets.chomp.downcase
    # print "Enter the ID: \#"
    # value = gets.chomp.to_i

    # display the current info, and always search by "first name"
    p contact = Contact.find_by(1, value)
    # p contact = Contact.find_by(0, value)

    puts "\nUpdate menu".upcase
    display_attribute_menu
    print "Select the field you wish to modify: "
    attribute = gets.chomp.to_i

    if attribute == 0
      puts "Error: Cannot change User ID".upcase
      return
    end

    if attribute >= 1 && attribute <= 5
      if attribute < 5
        print "Please enter the new value: "
        new_value = gets.chomp.downcase
        contact.update(attribute, new_value)

        puts ""
        p contact # show updated result
        puts ""
      else
        return
      end
    else
      puts "ERROR: Invalid Input".upcase
      clear_src
      return
    end
  end

  def delete_contact
    print "Please enter the first name of the contact you would like to delete: "
    name = gets.chomp.downcase
    contact = Contact.find_by(1, name)
    contact.delete
    puts ""
    puts "The entry has been deleted".upcase
    puts "Returning to main menu..."
    sleep(2)
    clear_src
  end

  def display_all_contacts
    clear_src
    p Contact.all
    puts ""
  end

  def search_by_attribute
    puts "\nSearch Menu".upcase
    display_attribute_menu
    print "Select the field you wish to search with: "
    attribute = gets.chomp.to_i

    if attribute >= 1 && attribute <= 5
      if attribute < 4
        print "Enter the value of the selected attribute: "
        value = gets.chomp.downcase

        contact = Contact.find_by(attribute, value)
        clear_src
        p contact
      elsif attribute == 4
        puts "ERROR: Field too broad".upcase
        return
      end
    else
      puts "ERROR: Invalid Input".upcase
      clear_src
      return
    end
  end

  def delete_all_entires
    Contact.delete_all
    puts ""
    puts "All entries have been deleted.".upcase
    puts "Returning to main menu..."
    sleep(2)
    clear_src
  end

  # clears terminal screen
  def clear_src
    puts "\e[H\e[2J"
  end

  def display_attribute_menu
    puts '[1] First Name'
    puts '[2] Last Name'
    puts '[3] Email Address'
    puts '[4] Notes'
    puts '[5] Return'
  end
end

ec_app = CRM.new("Evillious Chronicles")
ec_app.main_menu

at_exit do
  ActiveRecord::Base.connection.close
end