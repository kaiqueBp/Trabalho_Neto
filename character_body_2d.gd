extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var pular := false
var ataques := false
@onready var animacao := $animPlayer as AnimatedSprite2D

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
		
	if Input.is_action_just_pressed("ui_down") and is_on_floor():
		ataques = true
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if ataques:
		animacao.play("ataque")
	if direction:
		velocity.x = direction * SPEED
		animacao.scale.x = direction
		if !pular:
			animacao.play("correr")
	elif  pular: 
		animacao.play("pular")
	elif ataques:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animacao.play("parado")

	ataques = false
	move_and_slide()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "ataque":
		ataques = false
	 # Replace with function body.
