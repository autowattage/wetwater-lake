extends Area2D

func _on_body_entered(body: Node2D) -> void:
	Main.add_coin(1)
	queue_free()
