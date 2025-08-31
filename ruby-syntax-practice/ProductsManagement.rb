$items = Array.new()

def clear_console
    puts "\e[H\e[2J"
end

def get_user_input (actions)
    puts "\n"
    actions.each_with_index do | action, index |
        action_avaliable = index + 1
        puts action_avaliable.to_s + " - " + action
    end
    print "\nInsert Your Action: "
    user_action = gets().chomp()
    return user_action
end

def render_section_title (title)
    puts "======================"
    puts title
    puts "======================"
end

def validate_string (value)
    return !value.empty?
end

def validate_float (value)
    return /\A\d+\.\d+\z/.match?(value)
end

def validate_integer (value)
    return /\A\d+\z/.match?(value)
end

def validate_item_index (item_index)
    validate_integer(item_index) && item_index.to_i >= 0 && $items[item_index.to_i]
end

def validate_item_informations (fields_data)
    invalid_input_indexes = Array.new()

    fields_data.each_with_index do | field, index |
        case field[:type]
            when "string"
                if !validate_string(field[:value]) 
                    invalid_input_indexes << index
                end
            when "float"
                if !validate_float(field[:value]) && !validate_integer(field[:value])
                    invalid_input_indexes << index
                end
            when "integer"
                if !validate_integer(field[:value])
                    invalid_input_indexes << index
                end
        end
    end
    return invalid_input_indexes
end

def create_item
    fields_data = [
        { :label =>"Name", :value => nil, :type => "string", :key => "name" },
        { :label => "Price (Number)", :value => nil, :type => "float", :key => "price" },
        { :label => "Amount Avaliable (Number)", :value => nil, :type => "integer", :key => "amount_avaliable" }
    ]

    fields_data.each do | field |
        print "Insert Item " + field[:label] + ": "
        field[:value] = gets.chomp()
    end

    clear_console()

    invalid_field_indexes = validate_item_informations(fields_data)

    if invalid_field_indexes.length > 0
        invalid_field_indexes.each do | invalidFieldIndex |
            puts "Invalid Field: " + fields_data[invalidFieldIndex][:label].to_s
        end

        user_action = get_user_input(["Insert Again", "Cancel"])
        clear_console()
        
        if user_action == "1" 
            create_item()
        end
        return
    end

    item_data = Hash.new()
    
    fields_data.each do | itemParam |
        item_data[itemParam[:key]] = itemParam[:value] 
    end

    $items << item_data
    clear_console()

    puts "Item Created With Success!"
    puts ""
end

def update_item
    print "\nInsert Item ID To Update: "
    item_index = gets.chomp()
    clear_console()

    return puts "Insert A Valid ID!" unless validate_item_index(item_index)

    valid_index_to_update = ["1", "2", "3", "4"]
    field_index_to_update = nil

    while field_index_to_update != "4"
        item_data = $items[item_index.to_i]

        fields_data = [
            { :label =>"Name", :value => item_data["name"], :type => "string", :key => "name" },
            { :label => "Price (Number)", :value => item_data["price"], :type => "float", :key => "price" },
            { :label => "Amount Avaliable (Number)", :value => item_data["amount_avaliable"], :type => "integer", :key => "amount_avaliable" }
        ]
        
        actions_avaliable = fields_data.map { |field| "Update " + field[:label] + " : " + field[:value] } + ["Return"]
        
        render_section_title("Actions Avaliable")
        field_index_to_update = get_user_input(actions_avaliable)
        clear_console()

        valid_field_insert = valid_index_to_update.include?(field_index_to_update)


        if (!valid_field_insert)
            puts "Insert A Valid Field"
            puts ""
        end

        if field_index_to_update != "4"
            formatted_to_array_index = (field_index_to_update.to_i - 1)
            field_to_update = fields_data[formatted_to_array_index]

            title_displayed = "Update" + field_to_update[:label].to_s + " : " + field_to_update[:value].to_s
            render_section_title(title_displayed)

            print "\nInsert New Field Value: "
            updated_field = gets.chomp()
            clear_console()

            fields_data[formatted_to_array_index][:value] = updated_field
            invalid_fields = validate_item_informations([fields_data[formatted_to_array_index]])
            if (invalid_fields.length != 0) 
                puts "Invalid Value! Insert Again"
                puts ""
            else 
                puts "Item Updated"
                puts ""
                
                item_key_updated = fields_data[formatted_to_array_index][:key]
                $items[item_index.to_i][item_key_updated] = updated_field
            end
        end

        actions_avaliable = []
    end

    return field_index_to_update
end

def update_and_show_items
    user_action = nil
    while user_action != "2"
        none_items_registered = $items.length == 0
        show_items(none_items_registered)

        if none_items_registered
            return
        end

        return_field = "4"
        field_selected = update_item()

        return if return_field == field_selected

        user_action = get_user_input(["Update Item", "Return"])
        clear_console()
    end
    
end

def delete_item
    print "\nInsert Item ID To Delete: "
    item_id = gets.chomp()
    clear_console()

    return puts ("Invalid ID!") unless validate_item_index(item_id)
        
    $items.delete_at(item_id.to_i)
    puts ("Item Deleted!")
end

def delete_and_show_items
    user_action = nil

    while user_action != "2"
        none_items_registered = $items.length == 0
        show_items(none_items_registered)

        return unless !none_items_registered

        delete_item()
        
        user_action = get_user_input(["Delete Item", "Return"])
        clear_console()
    end
end

def show_items(await_for_key_pressed)
    render_section_title("Items List")

    exist_items = $items.length > 0

    if (exist_items) 
        $items.each_with_index do | item, index |
            puts "ID: " + index.to_s + " - Item Name: " + item["name"] + " - Price: U$" + item["price"] + " - Amount Available: " + item["amount_avaliable"] + "x"
        end
    else
        puts "None Items Found"
    end

    if await_for_key_pressed
        puts "\nPress Any Key To Continue"
        gets.chomp()
        clear_console()
    end
end

initial_action = nil
while initial_action != "5"
    actions_avaliable = ["Create Item",  "Update Item", "Delete Item", "Visualize Items", "Logged Out"]

    render_section_title("Items Management")
    initial_action = get_user_input(actions_avaliable)
    clear_console()

    case initial_action
        when "1"
            create_item()
        when "2"
            update_and_show_items()
        when "3"
            delete_and_show_items()
        when "4"
            show_items(true)
        when "5"
            puts "Logged Out"
    end
end