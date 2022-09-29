disable: make function! [
	"Disable a widget."
	face [object! block!]
] [
	foreach f reduce either object? face [[face]] [face] [
		unless 'disable = f/parent-face/type [
			change find f/parent-face/pane f make widgets/baseface [
				type: 'disable
				offset: f/offset
				size: f/size
				span: all [f/span copy f/span]
				pane: reduce [
					f
					make widgets/baseface [
						size: f/size
						span: all [
							f/span
							case [
								all [find f/span #"H" find f/span #"H"] [#HW]
								find f/span #"H" [#H]
								find f/span #"W" [#W]
							]
						]
						effect: [merge colorize 224.224.224]
					]
				]
				data: all [f/span copy f/span]
				feel: action: none
			]
			f/offset: 0x0
			if f/span [
				remove find f/span #"X"
				remove find f/span #"Y"
			]
			show f/parent-face
		]
	]
]