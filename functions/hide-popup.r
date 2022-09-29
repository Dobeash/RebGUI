hide-popup: make function! [
	"Undisplay current modal dialog/popup."
	/local face
][
	if find view*/pop-list view*/pop-face [
		face: any [view*/pop-face/parent-face screen*]
		remove find face/pane view*/pop-face
		remove back tail view*/pop-list
		;view*/pop-face: pick view*/pop-list length? view*/pop-list
		show face
	]
]