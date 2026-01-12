extends Control

const DEFAULT_STORAGE: Storage = preload("res://resouces/default_storage.tres")

@onready var hopStorageLabel: Label = $Panel/ItemsContainer/HopStorageLabel

func _ready() -> void:
	hopStorageLabel.text = "Hop: " + str(DEFAULT_STORAGE.hop)
