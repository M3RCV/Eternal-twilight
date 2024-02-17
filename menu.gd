extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _on_key_pressed(event):
	var children = get_children()
	var current_index = children.index($VBoxContainer/StartButton)

	# Переключиться на следующую кнопку
	if event.key == KEY_D:
		current_index += 1
		if current_index >= children.size():
			current_index = 0
		children[current_index].grab_focus()

	# Переключиться на предыдущую кнопку
	elif event.key == KEY_A:
		current_index -= 1
		if current_index < 0:
			current_index = children.size() - 1
		children[current_index].grab_focus()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Level0.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
