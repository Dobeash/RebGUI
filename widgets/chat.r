chat: make baseface [
	options: {
		USAGE:
			chat 120 data ["Bob" blue "My comment." yello 14-Apr-2007/10:58]

		DESCRIPTION:
			Three column chat display as found in IM apps such as AltME.
			Messages are appended, with those exceeding 'limit not shown.

		OPTIONS:
			[limit n] where n specifies number of messages to show (default 100)
			[id n] where n specifies id column width (default 10)
			[user n] where n specifies user column width (default 15)
			[date n] where n specifies date column width (default 25)
	}
	size: 200x100
	pane: []
	data: []
	edge: default-edge
	action: make default-action [
		on-resize: make function! [face] [
			poke face/pane/2/para/tabs 3 face/pane/1/size/x - (sizes/cell * any [select face/options 'date 25])
			face/redraw/no-show
		]
	]

	height: 0 ; actual pixel height of all messages (-1 ensures first message is offset to hide it's edge
	rows: 0 ; number of messages
	limit: none ; last n messages to display

	append-message: make function! [
		user [string!]
		user-color [tuple! word! none!]
		msg [string!]
		msg-color [tuple! word! none!]
		date [date!]
		/no-show row
		/local p y t1 t2 t3
	] [
		;	cache current tab stops
		t1: pick pane/2/para/tabs 1
		t2: pick pane/2/para/tabs 2
		t3: pick pane/2/para/tabs 3
		;	get height of message
		y: max sizes/line 4 + second size-text make baseface [
			size: as-pair t3 - t2 10000
			text: msg
			font: default-font
			para: para-wrap
		]
		p: self
		insert tail pane/1/pane reduce [
			make gradface [
				offset: as-pair -1 height - 1
				size: as-pair t1 y
				text: form any [row rows: rows + 1]
			]
			make baseface [
				offset: as-pair t1 - 1 height - 1
				size: as-pair t2 - t1 y
				text: user
				edge: make default-edge [size: 0x1]
				font: make font-top [color: either word? user-color [get user-color] [user-color] style: 'bold]
			]
			make baseface [
				offset: as-pair t2 - 1 height - 1
				size: as-pair t3 - t2 y
				span: all [p/span find p/span #W #W]
				text: form msg
				color: either word? msg-color [get msg-color] [msg-color]
				edge: make default-edge [size: 0x1]
				font: default-font
				para: para-wrap
			]
			make baseface [
				offset: as-pair t3 - 1 height - 1
				size: as-pair p/size/x - t3 - sizes/slider + 1 y
				span: all [p/span find p/span #W #X]
				text: form either now/date = date/date [date/time] [date/date]
				edge: make default-edge [size: 0x1]
				font: font-top
			]
		]
		height: height + y - 1
		if ((length? pane/1/pane) / 4) > limit [
			y: pane/1/pane/1/size/y - 1
			remove/part pane/1/pane 4
			foreach [i u m d] pane/1/pane [
				i/offset/y: u/offset/y: m/offset/y: d/offset/y: i/offset/y - y
			]
			height: height - y
		]
		unless no-show [
			insert tail data reduce [user user-color msg msg-color date]
			pane/1/size/y: height
			pane/3/ratio: pane/3/size/y / height
			show p
		]
		show pane/1 ; !!! this cleans up artifacts but "eats" other widgets redraw events !!!
	]

	set-user-color: make function! [id [integer!] color [tuple! word! none!] /local idx] [
		if any [zero? id id > rows] [exit]
		poke data id * 5 - 3 color
		if limit > (rows - id) [
			idx: either rows > limit [(id + limit - rows) * 4 - 2] [id * 4 - 2]
			pane/1/pane/:idx/font/color: either word? color [get color] [color]
			show pane/1/pane/:idx
		]
	]

	set-message-text: make function! [id [integer!] string [string!] /local idx] [
		if any [zero? id id > rows] [exit]
		poke data id * 5 - 2 string
		if limit > (rows - id) [
			idx: either rows > limit [(id + limit - rows) * 4 - 1] [id * 4 - 1]
			insert clear pane/1/pane/:idx/text string
			redraw
		]
	]

	set-message-color: make function! [id [integer!] color [tuple! word! none!] /local idx] [
		if any [zero? id id > rows] [exit]
		poke data id * 5 - 1 color
		if limit > (rows - id) [
			idx: either rows > limit [(id + limit - rows) * 4 - 1] [id * 4 - 1]
			pane/1/pane/:idx/color: either word? color [get color] [color]
			show pane/1/pane/:idx
		]
	]

	redraw: make function! [/no-show /local row] [
		clear pane/1/pane
		height: 0
		rows: (length? data) / 5
		row: max 0 rows - limit: any [select options 'limit 100]
		foreach [user user-color msg msg-color date] skip data row * 5 [
			append-message/no-show user user-color msg msg-color date row: row + 1
		]
		pane/1/size/y: height
		pane/3/ratio: either zero? height [1] [pane/3/size/y / height]
		unless no-show [show self]
	]

	init: make function! [/local p] [
		unless options [options: copy []]
		p: self
		limit: any [select options 'limit 100]
		insert pane make baseface [
			offset: as-pair 0 sizes/line
			size: p/size - as-pair sizes/slider sizes/line
			span: all [p/span find p/span #W #W]
			pane: []
		]
		;	heading
		insert tail pane make gradface [
			offset: -1x-1
			size: as-pair p/size/x sizes/line
			text: "ID^-User^-Message^-Sent"
			span: all [p/span find p/span #W #W]
			font: make font-button [align: 'left]
			para: make default-para [tabs: [0 0 0]]
		]
		;	set header tabs
		poke pane/2/para/tabs 1 sizes/cell * any [select options 'id 10]
		poke pane/2/para/tabs 2 sizes/cell * (any [select options 'user 15]) + pick pane/2/para/tabs 1
		poke pane/2/para/tabs 3 size/x - sizes/slider - (sizes/cell * any [select options 'date 25])
		;	vertical scroller
		insert tail pane make slider [
			offset: as-pair p/size/x - sizes/slider sizes/line - 2
			size: as-pair sizes/slider p/size/y - sizes/line + 2
			span: case [
				none? p/span [none]
				all [find p/span #H find p/span #W] [#XH]
				find p/span #H [#H]
				find p/span #W [#X]
			]
			action: make default-action [
				on-click: make function! [face] [
					if height > face/size/y [
						face/parent-face/pane/1/offset/y: (height - face/size/y * negate face/data) + sizes/line
						show face/parent-face
					]
				]
			]
		]
		pane/3/init
		action/on-resize self
	]
]