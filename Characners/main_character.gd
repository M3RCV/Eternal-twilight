extends CharacterBody2D

# Скорость перемещения
@export var move_speed : float = 300

func _physics_process(delta):
	
	# Направление перемещения
	var input_direction = Vector2(
		Input.get_action_strength("D_right") - Input.get_action_strength("A_left"),
		Input.get_action_strength("S_down") - Input.get_action_strength("W_up")
	)
	
	# Обновление скорости
	velocity = input_direction * move_speed

	# Функция скольжения при столкновении со стеной
	move_and_slide()
