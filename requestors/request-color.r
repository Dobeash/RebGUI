request-color: make function! [
	"Requests a color."
	/title text [string!] "Title text"
	/color clr [tuple!] "Default color"
	/local result bx
] [
	clr: any [clr colors/text]
	result: none
	display/dialog any [text "Color Palette"] compose [
		(color-spec)
		return bar return
		text "Red" spinner 15 data (clr/1) options [0 255 1] [bx/color/1: face/data show bx]
		bx: box 5x5 #L clr edge [] [result: bx/color hide-popup]
		return
		text "Green" spinner 15 data (clr/2) options [0 255 1] [bx/color/2: face/data show bx]
		return
		text "Blue" spinner 15 data (clr/3) options [0 255 1] [bx/color/3: face/data show bx]
		return
		bar
		reverse
		button "Cancel" [hide-popup]
		button "OK" [result: bx/color hide-popup]
		do [
			bx/size/y: sizes/cell * 17 ; reset box height
		]
	]
	result
]