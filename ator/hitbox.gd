extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "jogador":
		owner.animacao.play("morte")
		#owner.queue_free()
