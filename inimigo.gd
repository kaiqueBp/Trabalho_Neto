extends CharacterBody2D


const SPEED = 1000.0
const JUMP_VELOCITY = -400.0
var direction := -1
@onready var colisao := $colisao as RayCast2D
@onready var detectaGuerreiro := $detectaGuerreiro as RayCast2D
@onready var animacao := $animInimigo as AnimatedSprite2D
@onready var dano := $hitbox/colisaoDano as CollisionShape2D
@onready var death_screen := $"../CanvasLayer/Control" 
var start_position = Vector2(200, 500)
var start_position2 = Vector2(200, 0)
var start_position3 = Vector2(200,0)
@export var _timerInimigo : Timer = null
var danoCamp = false
var aux = false
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
		danoCamp = true
		
	else:
		animacao.play("andar")
		velocity.x = direction * SPEED * delta
	
	if danoCamp and not aux:
		_timerInimigo.start()
		aux = true
		danoCamp=false
	move_and_slide()
	
#func _ready() -> void:
	#death_screen.visible = false # Referência à UI de morte
##
##
#func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("jogador"):
		## Mostra a tela de "Você morreu"
		#death_screen.visible = true
		#body.set_physics_process(false)  # Pausa o movimento do jogador
##
#func reset_player():
		#global_position = start_position
		#set_physics_process(true)


func _on_timer_timeout() -> void:
	aux = false
	danoCamp = false
	var player = $"../jogador"
	death_screen.visible = true
	player.global_position = start_position  # Reinicia o jogador na posição inicial
	player.set_physics_process(true)  # Restaura o movimento
	death_screen.visible = false
	print("encontrou")
	
	
	#if player:  # Substitua pelo caminho correto até o nó do jogador
		
	
