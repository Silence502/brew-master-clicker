extends Control

@onready var brewButton: Button = $Panel/ButtonContainer/BrewButton
@onready var typeOptions: OptionButton = $Panel/ButtonContainer/TypeOptions
@onready var hopLabel: Label = $Panel/ButtonContainer/HopLabel
@onready var barleyLabel: Label = $Panel/ButtonContainer/BarleyLabel
@onready var waterLabel: Label = $Panel/ButtonContainer/WaterLabel
@onready var wheatLabel: Label = $Panel/ButtonContainer/WheatLabel
@onready var yeastLabel: Label = $Panel/ButtonContainer/YeastLabel

const LAGER_TYPE: BeerType = preload("res://resources/lager_type.tres")
const STOUT_TYPE: BeerType = preload("res://resources/stout_type.tres")
const IPA_TYPE: BeerType = preload("res://resources/ipa_type.tres")
const TRIPLE_TYPE: BeerType = preload("res://resources/triple_type.tres")
const WHITE_TYPE: BeerType = preload("res://resources/white_type.tres")


func _ready() -> void:
	var types: Array[BeerType] = [LAGER_TYPE, STOUT_TYPE, IPA_TYPE, TRIPLE_TYPE, WHITE_TYPE]
	
	typeOptions.item_selected.connect(_on_type_options_selected)
	brewButton.pressed.connect(_on_brew_button_pressed)
	
	options_builder(types)

func options_builder(items: Array[BeerType]):
	typeOptions.clear()
	for item in items:
		typeOptions.add_item(item.name)
		var index = typeOptions.item_count - 1
		typeOptions.set_item_metadata(index, item)
		
	if typeOptions.item_count > 0:
		typeOptions.selected = 0
		_on_type_options_selected(0)

# 2. MODIFICATION DE L'AFFICHAGE
func update_labels(selectedItem: BeerType):
	hopLabel.text = "Hop: %d" % [selectedItem.hop]
	barleyLabel.text = "Barley: %d" % [selectedItem.barley]
	waterLabel.text = "Water: %d" % [selectedItem.water]
	wheatLabel.text = "Wheat: %d" % [selectedItem.wheat]
	yeastLabel.text = "Yeast: %d" % [selectedItem.yeast]

func _on_type_options_selected(index: int):
	if index == -1: return
	var selected_item: BeerType = typeOptions.get_item_metadata(index)
	update_labels(selected_item)

func _on_brew_button_pressed():
	var index = typeOptions.selected
	if index == -1: return
		
	var selected_recipe: BeerType = typeOptions.get_item_metadata(index)
	
	if GameStorage.has_ingredients(selected_recipe):
		GameStorage.consume(selected_recipe)
	else:
		print("Pas assez d'ingrédients.")
