extends Area2D

@onready var reinit_screen := $"../CanvasLayer/Control" # Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reinit_screen.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if get_tree().current_scene.name == "Cena1":
		if body.is_in_group("jogador"):
			get_tree().change_scene_to_file("res://cena_2.tscn")
	elif get_tree().current_scene.name == "Cena2":
		if body.is_in_group("jogador"):
			get_tree().change_scene_to_file("res://cena_3.tscn")
	elif get_tree().current_scene.name == "Cena3":
		if body.is_in_group("jogador"):
			reinit_screen.visible = true
			body.set_physics_process(false) # Replace with function body.


func _on_button_pressed() -> void:
	if get_tree().current_scene.name == "Cena3":
		var player = $"../CharacterBody2D"
		get_tree().change_scene_to_file("res://node_2d.tscn")
		player.set_physics_process(true)  # Restaura o movimento
		reinit_screen.visible = false
			 # Replace with function body.
