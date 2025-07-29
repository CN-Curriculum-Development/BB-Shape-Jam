extends Area2D

func OnAreaExited(area):
	area.queue_free()
