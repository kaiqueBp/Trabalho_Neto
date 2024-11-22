extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var pular := false
var ataques := false
var ataqueFinal := true
var limite_esquerdo = 150
@onready var anim:= $animPlayer as AnimatedSprite2D
@onready var danoCausado := $DanoCausado as RayCast2D
@export var _timer : Timer = null
@export var _timerDano : Timer = null
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
		anim.play("ataque")
		ataques = true
		ataqueFinal = false
		_timerDano.start()
		_timer.start()

	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction <0 and position.x <= limite_esquerdo:
		direction = 0
	if direction:
		velocity.x = direction * SPEED
		anim.scale.x = direction
		danoCausado.scale.x = direction
		if !pular:
			anim.play("correr")
	elif  pular: 
		anim.play("pular")
	elif !ataques:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("parado")

	if danoCausado.is_colliding():
		if ataques:
			var inimigo = danoCausado.get_collider() 
			if ataqueFinal:
				if inimigo and inimigo.is_in_group("inimigo"): 
					inimigo.queue_free()
			
	move_and_slide()
	



func _on_ataque_tempo_timeout() -> void:
	ataques = false
	

func _on_dano_inimigo_timeout() -> void:
	ataqueFinal = true
