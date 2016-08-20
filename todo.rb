module Menu

	def menu
		puts "Please select one of the following:"
		puts
		puts "1) Add"
		puts "2) Show"
		puts "3) Update"
		puts "4) Delete"
		puts "5) Write to File"
		puts "6) Read from a File"
		puts "7) Toggle Task Status"
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
			item = "#{count}) #{item.to_machine}"
		}
	end

	def update(task_number, task)
		all_tasks[task_number - 1] = task
	end

	def delete(task_number)
		all_tasks.delete_at(task_number.to_i - 1)
	end
 
	def write_to_file(filename)
		my_file = File.new(filename, "w")
			my_file.puts all_tasks.collect { |task| 
				task.to_machine
			}
		my_file.close
	end

	def read_from_file(filename)
		all_tasks.clear
		IO.readlines(filename).each do |line| # [X] : my task, is great
            status, *description = line.split(':') # ["[X]", "My task, is great"]
            status = status.include?('X') # [X] = true
            add(Task.new(description.join(':').strip, status)) # description ["My task, is great"] = My task, is great, true
        end
	end

	def toggle(task_number)
		all_tasks[task_number - 1].toggle_status
	end
end

class Task

	attr_reader :description
	attr_reader :status

	def initialize(desc, status = false)
		@description = desc
		@status = status
	end

	def completed?
		status
	end

	# The default to_s method is called with every puts XYS. However the default to_s method prints the object's class and encoding of the object id

	def to_s
		@description
	end

	def to_machine
		represent_status + " : " + description
	end

	def toggle_status
		@status = !completed?
	end

	private

	def represent_status
		completed? ? "[X]" : "[ ]"
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
				puts
				my_list.add(Task.new(prompt("Add a name for the new task")))
				puts
				prompt("The task has been added!", "")
				puts
			when "2"
				puts
				puts "Your list of tasks:"
				puts
				puts my_list.show
				puts
			when "3"
				puts
				puts my_list.show
				puts
				my_list.update(prompt("Please enter task number to update").to_i,Task.new(prompt("Please enter a new description")))
				puts
				prompt("The task has been updated!", "")
				puts
			when "4"
				puts	
				puts my_list.show
				puts
				my_list.delete(prompt("Enter the number of the task to delete"))
				puts
				prompt("The task has been deleted!", "")
				puts
			when "5"
				puts
				my_list.write_to_file(prompt("Enter the name of the file") + ".txt")
				puts "The file has been saved!"
				puts
			when "6"
				begin
					puts
					my_list.read_from_file(prompt("Enter the name of the file") + ".txt")
					puts
					puts "The file has been opened!"
					puts
				rescue Errno::ENOENT
					puts
					puts "File name not found, please verify your file and path."
					puts
				end
			when "7"
				puts
				puts my_list.show
				puts
				my_list.toggle(prompt("Enter the task number to toggle status").to_i)
				puts
			else
				puts "Sorry, I did not understand"
			end
		end
	puts
	puts "Outro - Thanks for using the menu system!"
	puts 
end