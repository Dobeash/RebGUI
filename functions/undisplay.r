undisplay: make function! [
	"Closes parent display of face."
	face [object!]
] [
	while [face/parent-face] [face: face/parent-face]
	remove find screen*/pane face
	show screen*
]