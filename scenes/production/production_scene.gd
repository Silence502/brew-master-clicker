extends Control

@onready var brewButton: Button = $Panel/ButtonContainer/BrewButton
@onready var typeOptions: OptionButton = $Panel/ButtonContainer/TypeOptions
@onready var hopLabel: Label = $Panel/ButtonContainer/HopLabel
@onready var barleyLabel: Label = $Panel/ButtonContainer/BarleyLabel
@onready var waterLabel: Label = $Panel/ButtonContainer/WaterLabel
@onready var wheatLabel: Label = $Panel/ButtonContainer/WheatLabel
@onready var yeastLabel: Label = $Panel/ButtonContainer/YeastLabel

const LAGER_TYPE: BeerType = preload("res://resouces/lager_type.tres")
const STOUT_TYPE: BeerType = preload("res://resouces/stout_type.tres")
const IPA_TYPE: BeerType = preload("res://resouces/ipa_type.tres")
const TRIPLE_TYPE: BeerType = preload("res://resouces/triple_type.tres")
const WHITE_TYPE: BeerType = preload("res://resouces/white_type.tres")

func _ready() -> void:
	var types: Array[BeerType] = [
		LAGER_TYPE,
		STOUT_TYPE,
		IPA_TYPE,
		TRIPLE_TYPE,
		WHITE_TYPE
	]
	
	typeOptions.item_selected.connect(_on_type_options_selected)
	
	options_constructor(types)

func options_constructor(items: Array[BeerType]):
	typeOptions.clear()
	
	for item in items:
		typeOptions.add_item(item.name)
		var index = typeOptions.item_count - 1
		typeOptions.set_item_metadata(index, item)
		
	if typeOptions.item_count > 0:
		typeOptions.selected = 0
		_on_type_options_selected(0)

func update_labels(selectedItem: BeerType):
	hopLabel.text = "Hop: " + str(selectedItem.hop)
	barleyLabel.text = "Barley: " + str(selectedItem.barley)
	waterLabel.text = "Water: " + str(selectedItem.water)
	wheatLabel.text = "Wheat: " + str(selectedItem.wheat)
	yeastLabel.text = "Yeast: " + str(selectedItem.yeast)

func _on_type_options_selected(index: int):
	var selected_item: BeerType = typeOptions.get_item_metadata(index)
	update_labels(selected_item)
