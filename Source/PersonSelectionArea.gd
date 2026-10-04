extends Area3D
class_name PersonSelectionArea

enum {
	COMMAND_ASSING_UNITS,
}

var CurrentCommandStage : int = COMMAND_ASSING_UNITS
var SelectedUnits : Array[PersonCreature]

var ImSelectingUnits : bool

func _process(_Delta : float) -> void:
	if Input.is_action_pressed("Mouse_Left_Click"):
		ImSelectingUnits = true
	else:
		ImSelectingUnits = false

func add_to_selected_units(EspecifiedUnit : PersonCreature) -> void:
	if SelectedUnits.has(EspecifiedUnit) == true:
		return
	
	SelectedUnits.append(EspecifiedUnit)

func reassing_units_targets() -> void:
	pass

func _on_body_entered(Body : Node3D) -> void:
	if ImSelectingUnits != true:
		return
	
	if Body is PersonCreature:
		add_to_selected_units(Body)
