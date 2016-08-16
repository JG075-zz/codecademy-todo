module Menu

	def menu
		puts "Please select one of the following:"
		puts
		puts "1) Add"
		puts "2) Show"
		puts "3) Delete"
		puts "4) Write to File"
		puts "5) Read from a Fileee"
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
		count = 0
		all_tasks.collect { |item|
			count += 1
			item = "#{count}) #{item}"
		}
	end
 
	def write_to_file(filename)
		my_file = File.new(filename, "w")
			my_file.puts all_tasks
		my_file.close
	end

	def read_from_file(filename)
		my_file = File.new(filename, "r")
			my_file.readlines.each { |item|
				all_tasks << Task.new(item)
			}
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
			when "4"
				my_list.write_to_file(prompt("Enter the name of the file") + ".txt")
				puts "The file has been saved!"
				puts
			when "5"
				begin
					my_list.read_from_file(prompt("Enter the name of the file") + ".txt")
					puts
					puts "The file has been opened!"
					puts
				rescue Errno::ENOENT
					puts
					puts "File name not found, please verify your file and path."
					puts
				end
			else
				puts "Sorry, I did not understand"
			end
		end
	puts
	puts "Outro - Thanks for using the menu system!"
  
end