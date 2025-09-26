extends Area2D

func _on_body_entered(body: Node2D) -> void:
	Main.add_coin(5)
	queue_free()
