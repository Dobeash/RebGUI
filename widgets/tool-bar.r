tool-bar: make gradface [
	options: {
		USAGE:
			tool-bar data [arrow button field]
			tool-bar data [icon "Open" %actions/document-open.png []]

		DESCRIPTION:
			A toolbar with small margins (2x1) and minimal spacing (1x1).
	}
	size: -1x7
	feel: make default-feel [
		detect: make function! [face event /local var txt] [
			unless event [exit]
			if event/type = 'move [
				txt: none
				var: win-offset? face
				foreach f face/pane [
					all [
						f/type = 'icon
						within? event/offset - var f/offset f/size
						txt: f/text
						break
					]
				]
				either txt [
					var/x: var/x - sizes/cell
					var/y: var/y + sizes/cell
					face/.tip/text: txt
					face/.tip/size: size-text face/.tip
					face/.tip/offset: min event/offset - var as-pair event/offset/x - var/x face/size/y - face/.tip/size/y - 3
					show face/.tip
				] [
					all [
						face/.tip/show?
						hide face/.tip
					]
				]
			]
			event
		]
	]
	group: pane
	.tip: none
	init: make function! [/local p] [
		size/y: size/y + 2
		data: copy data
		insert data reduce ['margin 2x1 'space 1x1]
		data: layout/only data
		group: pane: data/pane
		p: self
		insert tail pane make baseface [
			color: yello
			edge: make default-edge [color: black]
			font: default-font
			show?: false
		]
		.tip: last pane
		all [negative? size/x size/x: data/size/x]
		data: none
	]
]