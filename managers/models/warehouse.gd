extends Node

signal warehouse_changed

@export var cask: int = 0:
	set(value):
		cask = value
		warehouse_changed.emit()

func has_cask_stock(cask: int) -> bool:
	return (cask > 0)

func remove_cask()
