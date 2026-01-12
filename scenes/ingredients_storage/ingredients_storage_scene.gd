extends Control

const DEFAULT_STORAGE: Storage = preload("res://resouces/default_storage.tres")

@onready var hopStorageLabel: Label = $Panel/ItemsContainer/HopStorageLabel
@onready var barleyStorageLabel: Label = $Panel/ItemsContainer/BarleyStorageLabel
@onready var wheatStorageLabel: Label = $Panel/ItemsContainer/WheatStorageLabel
@onready var waterStorageLabel: Label = $Panel/ItemsContainer/WaterStorageLabel
@onready var yeastStorageLabel: Label = $Panel/ItemsContainer/YeastStorageLabel

func _ready() -> void:
	# 1. On connecte le signal de la ressource à notre fonction de mise à jour
	if not DEFAULT_STORAGE.inventory_changed.is_connected(update_storage_display):
		DEFAULT_STORAGE.inventory_changed.connect(update_storage_display)
	
	# 2. On lance l'affichage une première fois pour l'initialisation
	update_storage_display()

# Cette fonction sera appelée automatiquement dès que le signal est émis
func update_storage_display() -> void:
	print("ingredients_storage_scene.gd : ", DEFAULT_STORAGE.hop)
	hopStorageLabel.text = "Hop: " + str(DEFAULT_STORAGE.hop)
	barleyStorageLabel.text = "Barley: " + str(DEFAULT_STORAGE.barley)
	wheatStorageLabel.text = "Wheat: " + str(DEFAULT_STORAGE.wheat)
	waterStorageLabel.text = "Water: " + str(DEFAULT_STORAGE.water)
	yeastStorageLabel.text = "Yeast: " + str(DEFAULT_STORAGE.yeast)
