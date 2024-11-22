extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("teste")
	if body.name == "inimigo":
		owner.queue_free()
	
	 # Replace with function body.
