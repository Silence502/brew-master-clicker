extends Control

@onready var hopStorageLabel: Label = $Panel/ItemsContainer/HopStorageLabel
@onready var barleyStorageLabel: Label = $Panel/ItemsContainer/BarleyStorageLabel
@onready var wheatStorageLabel: Label = $Panel/ItemsContainer/WheatStorageLabel
@onready var waterStorageLabel: Label = $Panel/ItemsContainer/WaterStorageLabel
@onready var yeastStorageLabel: Label = $Panel/ItemsContainer/YeastStorageLabel

func _ready() -> void:
	# 1. On connecte le signal de la ressource à notre fonction de mise à jour
	GameStorage.inventory_changed.connect(update_storage_display)
	update_storage_display()
	
	# 2. On lance l'affichage une première fois pour l'initialisation
	update_storage_display()

# Cette fonction sera appelée automatiquement dès que le signal est émis
func update_storage_display() -> void:
	hopStorageLabel.text = "Hop: " + str(GameStorage.hop)
	barleyStorageLabel.text = "Barley: " + str(GameStorage.barley)
	wheatStorageLabel.text = "Wheat: " + str(GameStorage.wheat)
	waterStorageLabel.text = "Water: " + str(GameStorage.water)
	yeastStorageLabel.text = "Yeast: " + str(GameStorage.yeast)
