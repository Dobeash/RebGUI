set-title: make function! [
	"Set and show window title."
	face [object!] "Any face in the window"
	title [string!] "Window bar title"
] [
	while [face/parent-face] [face: face/parent-face]
	face/text: title
	face/changes: 'text
	show face
]