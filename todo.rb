module Menu

	def menu
		puts "Please select one of the following:"
		puts
		puts "1) Add"
		puts "2) Show"
		puts "3) Write File"
		puts "4) Read from a File"
		puts "Q) Quit"
		puts
	end

	def show
		menu
	end

end

module Promptable

	def prompt(message = "What would you like to do?", symbol = ":> ")
		print message
		print symbol
		gets.chomp
	end

end

class List

	attr_reader :all_tasks

	def initialize
		@all_tasks = []
	end

	def add(task)
		all_tasks << task
	end

	def show
		all_tasks
	end

	def write_to_file(filename)
		my_file = File.new(filename, "w")
			my_file.puts all_tasks
		my_file.close
	end

end

class Task

	attr_reader :description

	def initialize(desc)
		@description = desc
	end

	# The default to_s method is called with every puts XYS. However the default to_s method prints the object's class and encoding of the object id

	def to_s
		@description
	end

end

if __FILE__ == $PROGRAM_NAME

	include Menu
	include Promptable

	my_list = List.new


	puts
	puts "Welcome to the Todo app!"
	puts
		until ["q"].include?(user_input = prompt(show).downcase)
			case user_input
			when "1"
				my_list.add(Task.new(prompt("Add a name for the new task")))
				prompt("The task has been successfully added!", "")
				puts
			when "2"
				puts "Your list of tasks:"
				puts
				puts my_list.show
				puts
			when "3"
				my_list.write_to_file(prompt("Enter the name of the file") + ".txt")
				puts "The file has been saved!"
				puts
			else
				puts "Sorry, I did not understand"
			end
		end
	puts
	puts "Outro - Thanks for using the menu system!"
  
end