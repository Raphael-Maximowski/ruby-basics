$tasks = Array.new()

def clear_console
    puts "\e[H\e[2J"
end

def validate_integer (integer)
    return /\A\d+\z/.match?(integer)
end

def validate_string(string)
    string && !string.empty?
end

def validate_task_index (task_index)
    !task_index.empty? && validate_integer(task_index) && $tasks[task_index.to_i]
end

def validate_tasks_length
    if ($tasks.is_a?(Array) && $tasks.length > 0)
        return true
    else
        print "Register A Task Before! Press Any Key To Continue"
        gets.chomp()
        clear_console()
        return false
    end
end

def validate_task_data (task_data)
    return if !task_data.is_a?(Hash)

    invalid_keys = Array.new()
    task_keys = task_data.keys

    task_keys.each_with_index do | key, index |
        invalid_keys << key if !validate_string(task_data[key])
    end
    
    return invalid_keys
end

def render_title (title)
    puts "=============================="
        puts "\n#{title}"
    puts "\n=============================="
    puts ""
end

def show_tasks_registered (render_top_line)
    exist_items_registered = $tasks.is_a?(Array) && $tasks.length > 0
    
    if render_top_line
        puts "\n=============================="
        puts ""
    end

    if exist_items_registered
        $tasks.each_with_index do | task, index |
            puts "ID: #{index} - Name: #{task["name"]} - Description: #{task["description"]} - Done: #{task["done"]}"
        end
    else
        puts "None Tasks Insert"
    end

    puts "\n=============================="
end

def get_user_action(options)
    return if !options.is_a?(Array) || options.length == 0

    valid_actions = Array.new()
    valid_action_insert = false
    user_action = nil

    puts ""
    while !valid_action_insert
        options.each_with_index do | option, index |
        action_index = "#{index + 1}"
        valid_actions << action_index
        puts "#{action_index} - #{option}"
        end

        print "\nInsert Your Action: "
        user_action = gets.chomp()
        clear_console()

        valid_action_insert = valid_actions.include?(user_action)

        puts "Invalid Action! Insert Again" unless valid_action_insert
    end

    return (user_action.to_i - 1)
end

def create_task
    return_last_section = false

    while !return_last_section
        render_title("Create Task")
        task = Hash.new()

        print "Insert Task Name: "
        task["name"] = gets.chomp()

        print "\nInsert Task Description: "
        task["description"] = gets.chomp()
        
        clear_console()

        invalid_fields = validate_task_data(task)
        return if !invalid_fields.is_a?(Array)

        if invalid_fields.length == 0
            task["done"] = false

            $tasks << task
            return_last_section = true
            return
        end

        invalid_fields.each do | invalid_field |
            puts "Invalid Field: #{invalid_field.capitalize()}"
        end

        print "\nPress Enter To Insert Data Again! "
        user_input = gets.chomp()
        clear_console()

        return_last_section = !user_input.empty?
    end
end

def delete_task
    return if !validate_tasks_length()

    return_last_section = ''
    while return_last_section.empty?
        show_tasks_registered(true)

        print "\nInsert Task ID: "
        task_index = gets.chomp()
        clear_console()

        valid_task_index = validate_task_index(task_index)

        if valid_task_index
            $tasks.delete_at(task_index.to_i)
            return_last_section = true
            return
        end

        puts "\nInvalid Task Id! Press Enter To Insert Again"
        return_last_section = gets.chomp()
        clear_console()
    end
end

def update_task_done_state
    return if !validate_tasks_length()

    return_last_section = ""
    while return_last_section.empty?

        show_tasks_registered(true)

        print "\nInsert Task ID: "
        task_index = gets.chomp()
        clear_console()

        valid_task_index = validate_task_index(task_index)

        if valid_task_index
            $tasks[task_index.to_i]["done"] = !$tasks[task_index.to_i]["done"]
            return_last_section = true
            return
        end

        puts "\nInvalid Task Id! Press Enter To Insert Again"
        return_last_section = gets.chomp()
        clear_console()
    end
end

initial_action = nil

while initial_action != 3
    actions_available = ["Create Task", "Delete Task", "Update Task Done State", "Return"]
    render_title("To Do List Management")
    show_tasks_registered(false)

    initial_action = get_user_action(actions_available)

    case initial_action
        when 0
            create_task()
        when 1
            delete_task()
        when 2
            update_task_done_state()
    end
end

puts "Logged Out"