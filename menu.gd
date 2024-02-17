extends Control

#Создаем переменную, индекса выбранной кнопки, а также массив кнопок
var current_button_index = 0
var buttons = []

func _ready():
	$VBoxContainer/StartButton.grab_focus()    #Устанавливаем фокус на элементе "StartButrton"
	var vbox_container = $VBoxContainer  # Получаем доступ к VBox контейнеру кнопок
	
	

	
	

#Заполняем массив "buttons" дочерними кнопками VBox контейнера
	for child in vbox_container.get_children(): 
		if child is Button:
			buttons.append(child)

func _process(delta: float):
#Обрабатываем срабатывание действия, вызванного нажатием кнопки "W"
	if Input.is_action_just_pressed("ui_s-down"):
		current_button_index = (current_button_index + 1) % buttons.size()    # Смещаем индекс выбранной кнопки на 1, и контролируем выход за пределы массива
		buttons[current_button_index].grab_focus()    # Устанавливаем фокус на кнопке с новым индексом

#Обрабатываем срабатывание действия, вызванного нажатием кнопки "S"
	if Input.is_action_just_pressed("ui_w-up"):
		current_button_index = (current_button_index - 1) % buttons.size()    # Смещаем индекс выбранной кнопки на -1, и контролируем выход за пределы массива
		buttons[current_button_index].grab_focus()    # Устанавливаем фокус на кнопке с новым индексом


	
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Level0.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
