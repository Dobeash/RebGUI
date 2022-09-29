in-widget: make function! [
	"Find matching widget types in a widget's pane."
	face [object!] "Widget"
	type [word!] "Widget type to find"
	/local blk
] [
	blk: copy []
	foreach f face/pane [
		all [
			f/type = type
			insert tail blk f
		]
	]
	blk
]