extends CharacterBody2D

# Скорость перемещения
@export var move_speed : float = 300

# Стартовое напрвление
@export var starting_direction: Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var idle_sprite = $Idle_Sprite
@onready var walk_sprite = $Walk_Sprite
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	
	# Создаем вектор направления перемещения в данный момент
	var input_direction = Vector2(
		Input.get_action_strength("D_right") - Input.get_action_strength("A_left"),
		Input.get_action_strength("S_down") - Input.get_action_strength("W_up")
	)
	# Корректировка скорости движения по диагонали
	if ((Input.get_action_strength("D_right") - Input.get_action_strength("A_left")) != 0 and (Input.get_action_strength("S_down") - Input.get_action_strength("W_up")) != 0):
		input_direction /= 1.4
	# Корректировка анимации отностиельно текущего вектора перемещения
	update_animation_parameters(input_direction)
	
	# Обновление скорости
	velocity = input_direction * move_speed

	# Функция скольжения при столкновении со стеной
	move_and_slide()
	# Выбераем новое состояние (анимацию) относительно скорости персонажа
	pick_new_state()
# Обновляем анимацию ходьбы и ожидания чтобы было все плавно
func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		
# Выбераем новое состояние (анимацию) относительно скорости персонажа
func pick_new_state():
	if (velocity != Vector2.ZERO): # Если скорость равна нулевому вектору
		state_machine.travel("Walk") # Изменяем состояние
		idle_sprite.visible = false # Скрываем спрайт с анимацией ожидания
		walk_sprite.visible = true
	else:
		state_machine.travel("Idle")
		idle_sprite.visible = true
		walk_sprite.visible = false
		
