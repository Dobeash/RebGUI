calendar: make baseface [
	options: {
		USAGE:
			calendar
			calendar data 1-Jan-2000

		DESCRIPTION:
			Used to select a date, with face/data set to current selection.
			Default selection is now/date.
	}
	size: 56x40
	color: colors/edit
	edge: default-edge
	feel: make default-feel [
		redraw: make function! [face act pos /local date month] [
			if act = 'show [
				date: face/date
				month: date/month
				date/day: 1
				date: date - date/weekday + 1
				foreach f skip face/pane 12 [
					f/text: form date/day
					f/font/color: either date/month = month [colors/text] [colors/outline/1]
					f/color: f/data: either all [date/month = month date = face/data] [
						f/font/color: colors/edit
						colors/theme/3
					] [none]
					date: date + 1
				]
				face/pane/3/text: reform [pick locale*/months face/date/month next next form face/date/year]
			]
		]
	]
	action: default-action
	date: none
	init: make function! [/local spec v] [
		spec: [
			tight
			btn 8 "|<" [face/parent-face/date/year: face/parent-face/date/year - 1 show face/parent-face]
			btn 8 "<" [face/parent-face/date/month: face/parent-face/date/month - 1 show face/parent-face]
			btn 24 [face/parent-face/date: face/parent-face/data show face/parent-face]
			btn 8 ">" [face/parent-face/date/month: face/parent-face/date/month + 1 show face/parent-face]
			btn 8 ">|" [face/parent-face/date/year: face/parent-face/date/year + 1 show face/parent-face]
			return
		]
		;	day labels
		foreach day locale*/days [
			insert tail spec compose [label 8 (copy/part day 3) font [align: 'center]]
		]
		;	7x6 day slots
		loop 6 [
			insert tail spec 'return
			loop 7 [
				insert tail spec [
					box 8x5 font [align: 'center valign: 'middle] feel [
						over: make function! [face into pos] [
							face/color: either all [into face/font/color <> colors/outline/1] [colors/theme/1] [face/data]
							show face
						]
						engage: make function! [face act event /local p] [
							if all [act = 'up face/font/color <> colors/outline/1] [
								p: face/parent-face
								p/data: p/date
								p/data/day: to integer! face/text
								show p
								p/action/on-click p
							]
						]
					]
				]
			]
		]
		v: any [data now/date]
		data: layout/only spec
		pane: data/pane
		foreach n pane [n/offset: n/offset - 1x1]
		repeat n 5 [pane/:n/size/x: pane/:n/size/x + 1]
		data: date: v
	]
]