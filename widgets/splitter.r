splitter: make gradface [
	options: {
		USAGE:
			area splitter area

		DESCRIPTION:
			Placed between two widgets on the same row or column.
			Allows both to be resized by dragging the splitter left/right or up/down respectively.
			Its size determines whether it is vertical or horizontal.
	}
	size: 2x25
	feel: make feel-click [
		redraw: make function! [face act pos /local f p n] [
			unless face/data [
				f: find face/parent-face/pane face
				p: back f
				n: next f
				if face/size/y <= face/size/x [
					while [face/offset/x <> p/1/offset/x] [
						if head? p [request-error "splitter failed to find previous widget"]
						p: back p
					]
					while [face/offset/x <> n/1/offset/x] [
						if tail? p [request-error "splitter failed to find next widget"]
						n: next n
					]
				]
				face/data: reduce [first p first n]
			]
		]
		engage: make function! [face act event /local p n delta] [
			switch act [
				down [set-state face on]
				up [set-state face off all [over? face event face/action/on-click face]]
				over [face/feel/over/state face on 0x0]
				away [face/feel/over/state face off 0x0]
			]
			if event/type = 'move [
				p: first face/data
				n: second face/data
				either face/size/y > face/size/x [
					;		face/text: "="
					delta: face/offset/x - face/offset/x: min n/offset/x + n/size/x - face/size/x - 1 max p/offset/x + 1 face/offset/x + event/offset/x
					p/size/x: p/size/x - delta
					n/size/x: n/size/x + delta
					n/offset/x: n/offset/x - delta
				] [
					;		face/text: "+"
					delta: face/offset/y - face/offset/y: min n/offset/y + n/size/y - face/size/y - 1 max p/offset/y + 1 face/offset/y + event/offset/y
					p/size/y: p/size/y - delta
					n/size/y: n/size/y + delta
					n/offset/y: n/offset/y - delta
				]
				show [p face n]
			]
			;	reset color if splitter is dragged out of bounds
			all [act = 'away face/feel/over face false 0x0]
		]
	]
	action: default-action
	init: make function! [] [
		effect/gradient: either size/y > size/x [text: "=" -1x0] [text: "+" 0x-1]
	]
]