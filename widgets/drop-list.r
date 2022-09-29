drop-list: make gradface [
	options: {
		USAGE:
			drop-list "1" data [1 2 3]
			drop-list data ["One" "Two" "Three"]
			drop-list data ctx-rebgui/locale*/colors

		DESCRIPTION:
			Single column modal selection list.
			At runtime face/text contains current selection.
	}
	size: 25x5
	text: ""
	data: []
	font: default-font
	feel: make feel-click [
		engage: make function! [face act event] [
			switch act [
				down [set-state face on]
				up [set-state face off all [over? face event face/pane/feel/engage face/pane act event]]
				over [face/feel/over/state face on 0x0]
				away [face/feel/over/state face off 0x0]
			]
		]
	]
	action: make default-action [
		on-resize: make function! [face] [
			face/pane/offset/x: face/size/x - sizes/line - 2
		]
		on-unfocus: make function! [face] [
			face/hidden-text: face/hidden-caret: none
			true
			;face/action face	; causes problems when set-focus used from another widget to assign and then shift focus
		]
	]
	hidden-caret: hidden-text: none
	;	Accessor functions
	picked: make function! [] [
		index? find data text
	]
	init: make function! [/local p] [
		unless block? data [request-error "drop-list expected data block"]
		para: make para [] ; avoid shared para object for scrollable input widget
		p: self
		pane: make baseface [
			offset: as-pair p/size/x - p/size/y - 2 0
			size: as-pair p/size/y - 2 p/size/y - 2
			effect: reduce ['arrow colors/text 'rotate 180]
			feel: make default-feel [
				engage: make function! [face act event /filter-data fd [block!] /local data p v lines oft] [
					if act = 'up [
						unless filter-data [edit/unfocus] ; unfocus if arrow pressed
						p: face/parent-face
						p/feel/over/state p off 0x0
						data: any [fd p/data]
						unless zero? lines: length? data [
							oft: either (lines * sizes/line) < (p/parent-face/size/y - p/offset/y - p/size/y) [
								;	fits below
								p/offset + as-pair 0 p/size/y - 1
							] [
								either (lines * sizes/line) <= (p/parent-face/size/y - 4) [
									;	fits bottom
									as-pair p/offset/x p/parent-face/size/y - 2 - (lines * sizes/line)
								] [
									;	align to bottom
									as-pair p/offset/x p/parent-face/size/y - 2 - (sizes/line * to integer! p/parent-face/size/y / sizes/line)
								]
							]
							if v: choose p p/size/x oft data [
								p/text: form v
								p/hidden-text: p/hidden-caret: none
								p/action/on-click p
								either p/type = 'drop-list [show p] [set-focus p]
							]
						]
					]
				]
			]
		]
	]
]