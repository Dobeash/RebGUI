show-popup: make function! [
	face [object!] "Face to show"
	/window window-face [object!] "Parent pane to appear in"
] [
	all [find view*/pop-list face exit]
	window: either window [window-face] [screen*]
	insert tail view*/pop-list view*/pop-face: face 
	insert tail window/pane face 
	show window
]