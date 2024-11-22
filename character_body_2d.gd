extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var pular := false
var ataques := false
var limite_esquerdo = 150
@onready var animacao := $animPlayer as AnimatedSprite2D
@export var _timer : Timer = null
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		pular = true
	elif is_on_floor():
		pular = false
		
		
	if Input.is_action_just_pressed("ui_down") and ataques == false:
		animacao.play("ataque")
		ataques = true
		_timer.start()

	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction <0 and position.x <= limite_esquerdo:
		direction = 0
	if direction:
		velocity.x = direction * SPEED
		animacao.scale.x = direction
		if !pular:
			animacao.play("correr")
	elif  pular: 
		animacao.play("pular")
	elif !ataques:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animacao.play("parado")

	move_and_slide()
	

func _on_ataque_tempo_timeout() -> void:
	ataques = false
	 # Replace with function body.
