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

const DEFAULT_STORAGE: Storage = preload("res://resouces/default_storage.tres")

func _ready() -> void:
	var types: Array[BeerType] = [
		LAGER_TYPE, STOUT_TYPE, IPA_TYPE, TRIPLE_TYPE, WHITE_TYPE
	]
	
	typeOptions.item_selected.connect(_on_type_options_selected)
	brewButton.pressed.connect(_on_brew_button_pressed)
	
	# 1. CONNEXION AU SIGNAL
	# On dit à cette scène : "Quand le stock change, rafraîchis l'affichage"
	if not DEFAULT_STORAGE.inventory_changed.is_connected(_refresh_display):
		DEFAULT_STORAGE.inventory_changed.connect(_refresh_display)
	
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

# 2. MODIFICATION DE L'AFFICHAGE
# On affiche le coût (BeerType) ET le stock (DEFAULT_STORAGE)
func update_labels(selectedItem: BeerType):
	hopLabel.text = "Hop: %d / %d" % [selectedItem.hop, DEFAULT_STORAGE.hop]
	barleyLabel.text = "Barley: %d / %d" % [selectedItem.barley, DEFAULT_STORAGE.barley]
	waterLabel.text = "Water: %d / %d" % [selectedItem.water, DEFAULT_STORAGE.water]
	wheatLabel.text = "Wheat: %d / %d" % [selectedItem.wheat, DEFAULT_STORAGE.wheat]
	yeastLabel.text = "Yeast: %d / %d" % [selectedItem.yeast, DEFAULT_STORAGE.yeast]

func _on_type_options_selected(index: int):
	if index == -1: return
	var selected_item: BeerType = typeOptions.get_item_metadata(index)
	update_labels(selected_item)

# 3. NOUVELLE FONCTION DE RAFRAÎCHISSEMENT
# Appelée automatiquement quand le signal inventory_changed est émis
func _refresh_display():
	# On simule une re-sélection de l'item actuel pour forcer la mise à jour des textes
	_on_type_options_selected(typeOptions.selected)

func _on_brew_button_pressed():
	var index = typeOptions.selected
	if index == -1: return
		
	var selected_recipe: BeerType = typeOptions.get_item_metadata(index)
	
	if DEFAULT_STORAGE.has_ingredients(selected_recipe):
		DEFAULT_STORAGE.consume(selected_recipe)
		# Pas besoin de mettre à jour les labels ici manuellement,
		# le signal inventory_changed va déclencher _refresh_display() !
		print("Brassage réussi !")
	else:
		print("Pas assez d'ingrédients.")
