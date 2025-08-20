@tool
extends Node

var DEVMODE: bool = true
var DEVMODE_TARGET_SCENE = "LANGUAGE_SELECT"
var LANG = {}
var LANGC = "English" # LANG_CURRENT

#Cosmic is actually "Magic" but I changed it to line up with the manual text.
enum ELEMENTS {
	PHYSICAL, COSMIC, ICE, FIRE, LIGHTNING, EARTH, SHADOW, POISON
}
var ELEMENT_COLORS: Array[String] = ["#C40000","#FB95C8","#68CBF4","#FF6600","#FFCC00","#856B47","#664D80","#508349"]
#var ELEMENTS: Array[String] = ["Physical","Cosmic","Ice","Fire","Lightning","Earth","Shadow","Poison"]

var Sound_Enabled := true
var Autosave_Enabled := true
var Difficulty = DIFFICULTIES.EASY
var Do_Tutorial = true

enum DIFFICULTIES {
	EASY,
	CHALLENGING,
	HEROIC
}

var STATE = {
	PlayerName = "Name",
	PlayerClass = 0,
	Difficulty = 0
}
