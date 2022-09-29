menu: make gradface [
	options: {
		USAGE:
			menu data ["Item-1" ["Choice 1" [alert "1"] "Choice 2" [alert "2"]] "Item-2" []]

		DESCRIPTION:
			Simple one-level text-only menu system.
	}
	size: 100x5
	pane: []
	color: colors/outline/1
	init: make function! [/local item item-offset] [
		item-offset: 0x0
		foreach [label block] data [
			insert tail pane make gradface [
				offset: item-offset
				size: as-pair 1 sizes/line
				text: label
				edge: none
				data: block
				font: make default-font [align: 'center]
				para: default-para
				feel: feel-click
				action: make default-action [
					on-click: make function! [face] [
						do select face/data choose face/parent-face face/options face/parent-face/offset + face/offset + as-pair 0 face/size/y - 1 extract face/data 2
					]
				]
				old-color: none
			]
			item: last pane
			item/options: item/size/x: sizes/line + first size-text item ; set item label width
			item-offset/x: item-offset/x + item/size/x ; set offset for next item label
			;	get max sub-menu size
			foreach i extract item/data 2 [
				item/options: max item/options sizes/cell + first text-size? i
			]
		]
		data: first pane
	]
]