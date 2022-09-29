area: make baseface [
	options: {
		USAGE:
			area
			area "Text" -1
			area "Text" 50x-1

		DESCRIPTION:
			Editable text area with wrapping and scroller.
	}
	size: 50x25
	text: ""
	color: colors/edit
	edge: default-edge
	font: font-top
	para: make para-wrap [margin: as-pair sizes/slider + 2 2]
	feel: make edit/feel [
		redraw: make function! [face act pos /local height total visible] [
			if act = 'show [
				; check for size change and resize scroller
				if face/size <> face/old-size [
					face/pane/offset/x: max 0 face/size/x - face/pane/size/x
					face/pane/size/y: face/size/y
				]
				if any [
					face/text-y <> height: second size-text face ; height of text changed?
					face/size <> face/old-size ; size changed?
				] [
					face/text-y: height

					total: face/text-y
					visible: face/size/y - (edge/size/y * 2) - para/origin/y - para/indent/y

					face/pane/ratio: either total > 0 [min 1 (visible / total)] [1]

					; update scroller step
					face/pane/step: either visible < total [min 1 (sizes/font-height / (total - visible))] [0]
				]
				;	Only update slider/data if scroll was caused by a key (not by slider itself). Avoids recursion.
				if all [face/pane/ratio < 1 face/key-scroll?] [

					do bind [
						; Update slider dragger position to reflect para/scroll/y
						; para/scroll is relative to  edge/size + para/origin + (para/indent * 0x1)

						total: text-y
						visible: size/y - (edge/size/y * 2) - para/origin/y - para/indent/y
						pane/data: - para/scroll/y / (total - visible)

					] face

					face/key-scroll?: false
				]
			]
		]
	]
	action: make default-action [
		on-resize: make function! [face] [
			face/pane/offset/x: face/size/x - sizes/slider
			face/pane/size/y: face/size/y
			face/line-list: none
		]
		on-scroll: make function! [face scroll /page /local total visible] [
			total: second size-text face
			visible: face/size/y - (face/edge/size/y * 2) - face/para/origin/y - face/para/indent/y
			face/para/scroll/y: either page [
				min max face/para/scroll/y - (visible * sign? scroll/y) (visible - total) 0
			] [
				min max face/para/scroll/y - (scroll/y * sizes/font-height) (visible - total) 0
			]
			; Update slider dragger position to reflect para/scroll/y
			; para/scroll is relative to edge/size + para/origin + (para/indent * 0x1)
			all [face/pane/data: - face/para/scroll/y / (total - visible)]
			show face
		]
	]
	esc: none
	caret: none
	undo: copy []
	text-y: none
	key-scroll?: false ; this is set to true by edit/edit-text to bypass slider action
	init: make function! [/local p] [
		para: make para [] ; avoid shared para object for scrollable input widget
		p: self
		text-y: second size-text self
		all [negative? size/x size/x: 10000 size/x: 4 + first size-text self]
		all [negative? size/y size/y: 10000 size/y: 8 + text-y]
		pane: make slider [
			offset: as-pair p/size/x - sizes/slider -1
			size: as-pair sizes/slider p/size/y
			action: make default-action [
				on-click: make function! [face /local visible] [
					;	Only update slider/data if scroll was caused by a key (not by slider itself). Avoids recursion.
					unless parent-face/key-scroll? [
						visible: (parent-face/size/y - (parent-face/edge/size/y * 2) - parent-face/para/origin/y - parent-face/para/indent/y)
						parent-face/para/scroll/y: negate parent-face/text-y - visible * data
						show parent-face
					]
					parent-face/key-scroll?: false
				]
			]
			ratio: p/size/y - 4 / text-y
		]
		pane/init
	]
]