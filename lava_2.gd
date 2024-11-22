extends Area2D

var start_position = Vector2(200, 500)
var start_position2 = Vector2(200, 0)
var start_position3 = Vector2(200,0)

@onready var death_screen := $"../CanvasLayer/Control" 

func _ready() -> void:
	death_screen.visible = false # Referência à UI de morte


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		# Mostra a tela de "Você morreu"
		death_screen.visible = true
		body.set_physics_process(false)  # Pausa o movimento do jogador

func reset_player():
		global_position = start_position
		set_physics_process(true)

func _on_button_pressed() -> void:
	if get_tree().current_scene.name == "Cena1":
		var player = $"../CharacterBody2D"
		if player:  # Substitua pelo caminho correto até o nó do jogador
			player.global_position = start_position  # Reinicia o jogador na posição inicial
			player.set_physics_process(true)  # Restaura o movimento
			death_screen.visible = false
			print("encontrou")
	if get_tree().current_scene.name == "Cena2":
		var player = $"../CharacterBody2D"
		if player:  # Substitua pelo caminho correto até o nó do jogador
			player.global_position = start_position2  # Reinicia o jogador na posição inicial
			player.set_physics_process(true)  # Restaura o movimento
			death_screen.visible = false
			print("encontrou")
	
		
	else:
		print("nao encontrado")
		  # Oculta a tela de "Você morreu"
