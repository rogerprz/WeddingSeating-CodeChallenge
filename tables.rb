class Table

  attr_accessor :name, :max_size, :guest_names,:seats_taken
  ALL = []

  def initialize(name, max_size,seats_taken = 0 )
    @name = name
    @max_size = max_size
    @guest_names = []
    @seats_taken = seats_taken
    ALL << self
  end

  def self.all
    ALL
  end

  def self.tables_data(str_input)
    tables = str_input.split(":")[1].split(" ")
    tables.each do |table|
      name = table.split("-")[0]
      max_size = table.split("-")[1].to_i
      Table.new(name, max_size, )
    end
  end

  def self.fill_tables
    guests_present = []
    Table.all.map do |table|
      Guest.all.map do |guest|
        overload = table.seats_taken + guest.size
        dislikes = guest.dislikes
        table_size = table.max_size
        # binding.pry
        if guest.seated
          puts 'Already seated'
        elsif overload <= table_size && dislikes != nil
          dislikes.each do |person|
            if !table.guest_names.include?(person)
              guests_present << "#{guest.name} party of #{guest.size}"
              table.guest_names << guest.name
              table.seats_taken += guest.size
              guest.seated = true
              binding.pry
            end
          end
        elsif overload <= table_size && !table.guest_names.include?(guest.name)
          guests_present << "#{guest.name} party of #{guest.size}"
          table.guest_names << guest.name
          table.seats_taken += guest.size
          guest.seated = true
          binding.pry
        end
        binding.pry
      end
    end
    Guest.all.each do |guest|
      if !guest.seated
        puts "Unable to seat all guests"
        break
      end
    end
    guests_present.each {|present| puts present}
    puts "All haters seated"
  end

end
