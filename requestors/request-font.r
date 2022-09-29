request-font: make function! [
	"Requests a font name, returning a string."
	/title text [string!] "Title text"
	/object "Adds style, size and align selectors (returns font! object!)"
	/local result f blk
] [
	get-fonts
	f: rejoin ["Fonts (" length? fonts ")"]
	result: none
	blk: either object [
		compose [
			group-box 50x43 (f) data [
				text-list #LV data fonts [f/font/name: copy f/text: copy face/selected show f]
			]
			group-box 25x43 "Style" data [
				after 1
				radio-group data [1 "Normal" "Bold" "Italic" "Underline"] [f/font/style: pick reduce [none 'bold 'italic 'underline] face/picked show f]
				label "Size"
				spinner #L options [8 36 2] data 24 [f/font/size: face/data show f]
			]
			group-box 25x43 "Align" data [
				radio-group data [2 "left" "center" "right"] [f/font/align: to word! face/selected show f]
				return
				radio-group data [2 "top" "middle" "bottom"] [f/font/valign: to word! face/selected show f]
			]
			after 1
		]
	] [
		compose [
			after 1
			label (f)
			text-list 50x30 data fonts [f/font/name: copy f/text: copy face/selected show f]
		]
	]
	insert tail blk [
		f: field #L effects/font 20x20 edge [size: 0x0] font [size: 24 align: 'center]
		bar
		reverse
		button "Cancel" [hide-popup]
		button "OK" [result: either object [f/font] [f/font/name] hide-popup]
	]
	display/dialog any [text "Available Fonts"] blk
	result
]