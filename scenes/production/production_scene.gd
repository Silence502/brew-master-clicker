extends Control

@onready var brewButton: Button = $Panel/ButtonContainer/BrewButton
@onready var typeOptions: OptionButton = $Panel/ButtonContainer/TypeOptions
@onready var hopLabel: Label = $Panel/ButtonContainer/HopLabel

const LAGER_TYPE: BeerType = preload("res://resouces/lager_type.tres")
const STOUT_TYPE: BeerType = preload("res://resouces/stout_type.tres")
const IPA_TYPE: BeerType = preload("res://resouces/ipa_type.tres")
const TRIPLE_TYPE: BeerType = preload("res://resouces/triple_type.tres")
const WHITE_TYPE: BeerType = preload("res://resouces/white_type.tres")

func _ready() -> void:
	var types = [
		LAGER_TYPE,
		STOUT_TYPE,
		IPA_TYPE,
		TRIPLE_TYPE,
		WHITE_TYPE
	]
	
	typeOptions.item_selected.connect(_on_type_options_selected)
	
	options_constructor(types)

func options_constructor(items):
	for item in items:
		typeOptions.add_item(item.name)
		var index = typeOptions.item_count - 1
		typeOptions.set_item_metadata(index, item)

func update_hop_label():
	print("test")

func _on_type_options_selected(index: int):
	var selected_item: BeerType = typeOptions.get_item_metadata(index)
	hopLabel.text = "Hop: " + str(selected_item.hop)
	print(selected_item.name)
