##Base class for states
##will contain some abstract storage and share functions
##but mostly for developing reasons.
class_name State extends Resource
signal data_changed(key:String, value:Variant)

#NOTE: states will have their own values declared by types
#this is for testing new ones before setting up a dedicated place
#it can be used as is, but may not work well with a lot of data
var _data : Dictionary[String,Variant]
func has_data(key:String)->bool:
	return _data.has(key)
func get_data(key:String)->Variant:
	if _data.has(key):
		return _data[key]
	return null
func set_data(key:String, value:Variant)->void:
	var old_value = get_data(key)
	if old_value != value:
		_data[key] = value
		data_changed.emit(key, value)
