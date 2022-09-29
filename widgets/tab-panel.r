tab-panel: make baseface [
	options: {
		USAGE:
			tab-panel data ["A" [field] "B" [field] "C" [field]]
			tab-panel data ["1" [field] action [face/color: red] "2" [field]]

		DESCRIPTION:
			A panel with a set of tabs.
			Each tab spec may be preceded by an action block spec.

		OPTIONS:
			'action do action of initial tab (if any)
			[tab n] where n specifies tab to initially open with (default 1)
			no-tabs do not display tabs (overlay mode)
	}
	;	tabs indicates number of tabs
	;	data holds current tab number
	;	pane/n holds tab data n
	;	pane/n + tabs holds tab title n
	;	pane/selected will have show?: true, others show?: false
	size: -1x-1
	pane: []
	;
	;	Extended attributes
	;
	group: none
	tabs: 0
	;
	;	Access functions
	;
	selected: make function! [] [
		either find options 'no-tabs [data] [pane/(tabs + data)/text]
	]
	select-tab: make function! [
		num [integer!]
	] [
		unless any [num < 1 num > tabs] [
			edit/unfocus
			pane/:data/show?: false
			unless find options 'no-tabs [
				deselect-face pane/(tabs + data)
				select-face pane/(tabs + num)
			]
			pane/(data: num)/show?: true
			all [pane/:data/action pane/:data/action/on-click pane/:data]
			group: pane/:data/pane
			show self
		]
	]
	replace-tab: make function! [
		num [integer!]
		block [block!]
		/title text [string!]
		/local prev-offset prev-size prev-span
	] [
		unless any [num < 1 num > tabs] [
			prev-offset: pane/1/offset
			prev-size: pane/1/size
			prev-span: pane/1/span
			pane/:num: layout/only block
			pane/:num/offset: prev-offset
			pane/:num/size: prev-size
			pane/:num/span: prev-span
			pane/:num/color: colors/page
			pane/:num/edge: default-edge
			all [title pane/(tabs + num)/text: text]
			if data <> num [pane/:num/show?: false]
			show self
		]
	]
	;
	;	Init
	;
	init: make function! [/local tab tab-offset trigger] [
		unless options [options: copy []]
		tab-offset: 0x0
		foreach [title spec] data [
			either title = 'action [
				trigger: spec
			] [
				;	tab number
				tabs: tabs + 1
				;	insert panel
				tab: layout/only spec
				tab/offset/y: either find options 'no-tabs [0] [sizes/line]
				tab/color: colors/page
				tab/edge: default-edge
				tab/show?: false
				tab/span: #LV
				tab/action: either trigger [
					make default-action [on-click: make function! [face /local var] trigger]
				] [none]
				insert at pane tabs tab
				;	insert tab
				unless find options 'no-tabs [
					insert tail pane make gradface [
						offset: tab-offset
						size: as-pair 1 sizes/line + 1
						font: make font-button []
						text: title
						data: tabs
						feel: feel-click
						action: make default-action [
							on-click: make function! [face] [
								face/parent-face/select-tab face/data
							]
						]
						old-color: none
					]
					tab: last pane
					tab/size/x: 8 + first size-text tab ; set tab title width
					tab-offset/x: tab-offset/x + tab/size/x - 1 ; set offset for next tab title
				]
				trigger: none
			]
		]
		;	auto size adjustments
		all [
			negative? size/x
			repeat i tabs [size/x: max size/x pane/:i/size/x]
		]
		all [
			negative? size/y
			repeat i tabs [size/y: max size/y pane/:i/size/y]
			size/y: size/y + either find options 'no-tabs [0] [sizes/line]
		]
		;	set parent span resize
		unless all [span find span #H find span #W] [
			repeat n tabs [
				foreach widget pane/:n/pane [
					if widget/span [
						all [find widget/span #H either span [insert tail span #H] [span: #H]]
						all [find widget/span #W either span [insert tail span #W] [span: #W]]
					]
					all [span find span #H find span #W break]
				]
				all [span find span #H find span #W break]
			]
		]
		;	set tab span resize
		if span [
			repeat n tabs [
				all [find span #H either pane/:n/span [insert tail pane/:n/span #H] [pane/:n/span: #H]]
				all [find span #W either pane/:n/span [insert tail pane/:n/span #W] [pane/:n/span: #W]]
			]
		]
		;	show selected tab
		pane/(data: any [select options 'tab 1])/show?: true
		;	point to child widgets
		group: pane/:data/pane
		unless find options 'no-tabs [select-tab data]
		all [find options 'action pane/:data/action pane/:data/action/on-click pane/:data]
	]
]