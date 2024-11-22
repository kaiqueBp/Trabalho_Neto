extends CharacterBody2D


const SPEED = 1000.0
const JUMP_VELOCITY = -400.0
var direction := -1
@onready var colisao := $colisao as RayCast2D
@onready var detectaGuerreiro := $detectaGuerreiro as RayCast2D
@onready var animacao := $animInimigo as AnimatedSprite2D
@onready var dano := $hitbox/colisaoDano as CollisionShape2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	animacao.scale.x = direction
	
	if colisao.is_colliding():
		direction *= -1
		colisao.scale.x *= -1
		detectaGuerreiro.scale.x *= -1
		animacao.scale.x = direction
		
	if detectaGuerreiro.is_colliding():
		animacao.play("danoCausado")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		animacao.play("andar")
		velocity.x = direction * SPEED * delta
	
	move_and_slide()
	
