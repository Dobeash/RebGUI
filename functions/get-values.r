get-values: make function! [
	"Gets values from input widgets within a display or grouping widget."
	face [object!] "Display face"
	/type "Precede each value with its type"
	/local blk
] [
	blk: copy []
	foreach widget either in face 'group [face/group] [face/pane] [
		if find [
			area
			calendar
			check
			check-group
			drop-list
			edit-list
			field
			group-box
			led
			led-group
			panel
			password
			progress
			radio-group
			scroll-panel
			sheet
			slider
			spinner
			tab-panel
			table
			text-list
			tool-bar
			tree
		] widget/type [
			all [type insert tail blk widget/type]
			insert/only tail blk case [
				find [area drop-list edit-list field password] widget/type [widget/text]
				find [calendar check check-group led led-group progress slider spinner] widget/type [widget/data]
				find [radio-group table text-list tree] widget/type [widget/picked]
				true [either type [get-values/type widget] [get-values widget]]
			]
		]
	]
	blk
]