extends HBoxContainer
class_name ResourceAmountBar

@export var ResourceTextureNode : TextureRect
@export var ResourceRequiredLabelNode : Label
@export var BraquetStartLabelNode : Label
@export var ResourceTotalStoredLabelNode : Label
@export var BraquetEndLabelNode : Label

var ResourceIcon : CompressedTexture2D = preload("res://Assets/Textures/GUI/Luciferase.svg")

var AssignedResourceKey : String = "Wood"
var ShowResourcesRequired : bool

func _process(_Delta : float) -> void:
	if AssignedResourceKey == "":
		return
	
	if ResourceTotalStoredLabelNode == null:
		return
	
	var TotalResourceStored : int = CivilizationsInfo.CivilizationsInfoDictionary[GeneralGameData.PlayerCivilizationName].get_civilization_resource(AssignedResourceKey)
	ResourceTotalStoredLabelNode.text = str(TotalResourceStored)

func update_descriptions() -> void:
	if ResourceTextureNode == null or ResourceRequiredLabelNode == null or\
	   BraquetStartLabelNode == null or BraquetEndLabelNode == null:
		return
	
	ResourceTextureNode.texture = ResourceIcon
	ResourceTextureNode.tooltip_text = AssignedResourceKey
	
	if ShowResourcesRequired == true:
		BraquetStartLabelNode.show()
		ResourceRequiredLabelNode.show()
		BraquetEndLabelNode.show()
	else:
		BraquetStartLabelNode.hide()
		ResourceRequiredLabelNode.hide()
		BraquetEndLabelNode.hide()
