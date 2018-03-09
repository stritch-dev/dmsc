require_relative '../lib/dm_class.rb'

puts "Hello."
DmClass.scrape_calendar_page('http://desmoinessocialclub.org/class-schedule/')
DmClass.list_class_titles
choice = ""
while( true )
  puts "\n\nPlease enter the number for the class that interests you or type 'e' to exit the program."
  choice = gets.strip
  if choice == 'e' 
    break
  end
  puts "\nClass #{choice} is #{DmClass.all[choice.to_i].title}"
  DmClass.all[choice.to_i].print_description
end



