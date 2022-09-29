layout: make function! [
	"Parse/layout a block of widgets, attributes and keywords."
	spec [block!] "Block of widgets, attributes and keywords"
	/only "Do not change face offset"
	/local
	view-face
	here
	margin-size indent-width xy gap-size max-width max-height last-widget widget-face arg append-widget left-to-right?
	after-count after-limit
	word
	widget
	disable?
	button-size
	field-size
	label-size
	text-size
	action-alt-click
	action-away
	action-click
	action-dbl-click
	action-edit
	action-focus
	action-key
	action-over
	action-resize
	action-scroll
	action-time
	action-unfocus
	attribute-size
	attribute-span
	attribute-text
	attribute-text-color
	attribute-text-style
	attribute-color
	attribute-image
	attribute-effect
	attribute-data
	attribute-edge
	attribute-font
	attribute-para
	attribute-feel
	attribute-rate
	attribute-show?
	attribute-options
	attribute-keycode
] [
	margin-size: xy: sizes/margin-size
	gap-size: sizes/gap-size

	indent-width: 0
	max-width: xy/x
	max-height: xy/y

	unless only [clear disable-widgets]
	left-to-right?: true
	after-count: 1
	after-limit: 10000

	view-face: make widgets/baseface [
		pane: copy [] ; copy needed to prevent "face in more than one pane" errors
		color: colors/page
		effect: all [not only effects/window]
		options: copy [activate-on-show]
		data: copy []
		span-size: init: none
	]

	;	append widgets and set attributes

	append-widget: make function! [] [
		if widget [
			insert tail view-face/pane make widgets/:widget [
				type: either widgets/:widget/type = 'face [widget] [widgets/:widget/type]
				offset: xy
				size: sizes/cell * any [
					all [
						attribute-size
						either pair? attribute-size [attribute-size] [as-pair attribute-size size/y]
					]
					all [
						widget = 'bar
						as-pair max-width - margin-size/x / sizes/cell size/y
					]
					all [
						button-size
						widget = 'button
						either pair? button-size [button-size] [as-pair button-size size/y]
					]
					all [
						field-size
						widget = 'field
						either pair? field-size [field-size] [as-pair field-size size/y]
					]
					all [
						label-size
						widget = 'label
						either pair? label-size [label-size] [as-pair label-size size/y]
					]
					all [
						text-size
						widget = 'text
						either pair? text-size [text-size] [as-pair text-size size/y]
					]
					size
				]
				span: any [attribute-span span]
				text: any [attribute-text text]
				effect: any [attribute-effect effect]
				data: either any [attribute-data = false data = false] [false] [any [attribute-data data]]
				rate: any [attribute-rate rate]
				show?: either none? attribute-show? [show?] [attribute-show?]
				options: attribute-options
				color: any [attribute-color color]
				image: any [attribute-image image]
				;	locale substitutions
				text: translate text
				data: translate data
				;	text color & style
				all [
					attribute-text-color
					font: make any [font widgets/default-font] [color: attribute-text-color]
				]
				all [
					attribute-text-style
					font: make any [font widgets/default-font] [style: attribute-text-style]
				]
				;	edge / font / para / feel objects
				all [attribute-edge edge: make any [edge widgets/default-edge] attribute-edge]
				all [attribute-font font: make any [font widgets/default-font] attribute-font]
				all [attribute-para para: make any [para widgets/default-para] attribute-para]
				all [attribute-feel feel: make any [feel widgets/default-feel] attribute-feel]
				;	action object
				if any [
					action-alt-click
					action-away
					action-click
					action-dbl-click
					action-edit
					action-focus
					action-key
					action-over
					action-resize
					action-scroll
					action-time
					action-unfocus
				][
					action: make any [action widgets/default-action] [
						all [
							action-alt-click
							on-alt-click: make function! [face /local var] action-alt-click
						]
						all [
							action-away
							on-away: make function! [face /local var] action-away
						]
						all [
							action-click
							on-click: make function! [face /local var] action-click
						]
						all [
							action-dbl-click
							on-dbl-click: make function! [face /local var] action-dbl-click
						]
						all [
							action-edit
							on-edit: make function! [face /local var] action-edit
						]
						all [
							action-focus
							on-focus: make function! [face /local var] action-focus
						]
						all [
							action-key
							on-key: make function! [face event /local var] action-key
						]
						all [
							action-over
							on-over: make function! [face /local var] action-over
						]
						all [
							action-resize
							on-resize: make function! [face /local var] action-resize
						]
						all [
							action-scroll
							on-scroll: make function! [face scroll /page /local var] action-scroll
						]
						all [
							action-time
							on-time: make function! [face /local var] action-time
						]
						all [
							action-unfocus
							on-unfocus: make function! [face /local var] action-unfocus
						]
					]
				]
				if action [
					unless feel [
						feel: make widgets/default-feel []
					]
					;	action block and associated engage feel
					if any [
						get in action 'on-alt-click
						get in action 'on-click
						get in action 'on-dbl-click
						get in action 'on-edit
						get in action 'on-key
						get in action 'on-scroll
						get in action 'on-time
					] [
						unless get in feel 'engage [
							feel/engage: make function! [face act event] [
								case [
									event/double-click [face/action/on-dbl-click face]
									event/type = 'time [face/action/on-time face]
									act = 'up [face/action/on-click face]
									act = 'alt-up [face/action/on-alt-click face]
									act = 'key [
										face/action/on-key face event
										face/action/on-edit face
									]
									act = 'scroll-line [face/action/on-scroll face event/offset]
									act = 'scroll-page [face/action/on-scroll/page face event/offset]
								]
							]
						]
					]
					;	action block and associated over feel
					if any [
						get in action 'on-away
						get in action 'on-over
					] [
						unless get in feel 'over [
							feel/over: make function! [face into pos] [
								either into [face/action/on-over face] [face/action/on-away face]
							]
						]
					]
				]
			]
			last-widget: last view-face/pane
			;	keycode attached?
			all [
				attribute-keycode
				insert tail view-face/data reduce [attribute-keycode last-widget]
			]
			;	any init required?
			if in last-widget 'init [
				last-widget/init ; execute
				last-widget/init: none ; free
			]
			all [disable? insert tail disable-widgets last-widget]
			;	1st reverse item?
			unless left-to-right? [
				last-widget/offset/x: last-widget/offset/x - last-widget/size/x
			]
			xy: last-widget/offset
			;	max vertical size
			max-height: max max-height xy/y + last-widget/size/y
			;	horizontal pos adjustments
			all [
				left-to-right?
				xy/x: xy/x + last-widget/size/x
				max-width: max max-width xy/x
			]
			;	after limit reached?
			after-count: either after-count < after-limit [
				;	spacing
				xy/x: xy/x + either left-to-right? [gap-size/x] [negate gap-size/x]
				after-count + 1
			] [
				xy: as-pair margin-size/x + indent-width max-height + gap-size/y
				after-count: 1
			]
			all [:word set :word last-widget]
			word:
			widget:
			disable?:
			action-alt-click:
			action-away:
			action-click:
			action-dbl-click:
			action-edit:
			action-focus:
			action-key:
			action-over:
			action-resize:
			action-scroll:
			action-time:
			action-unfocus:
			attribute-size:
			attribute-span:
			attribute-text:
			attribute-text-color:
			attribute-text-style:
			attribute-color:
			attribute-image:
			attribute-effect:
			attribute-data:
			attribute-edge:
			attribute-font:
			attribute-para:
			attribute-feel:
			attribute-rate:
			attribute-show?:
			attribute-options:
			attribute-keycode: none
		]
	]

	parse reduce/only spec words [
		any [
			opt [here: set arg paren! (here/1: do arg) :here] [
				'return (
					append-widget
					xy: as-pair margin-size/x + indent-width max-height + gap-size/y
					left-to-right?: true
					after-limit: 10000
				)
				| 'reverse (
					append-widget
					xy: as-pair max-width max-height + gap-size/y
					left-to-right?: false
					after-limit: 10000
				)
				| 'after set arg integer! (
					;	return unless this is first widget
					if widget [
						append-widget
						xy: as-pair margin-size/x + indent-width max-height + gap-size/y
					]
					after-count: 1
					after-limit: arg
				)
				| 'disable (disable?: true)
				| 'button-size [set arg integer! | set arg pair! | | set arg none!] (button-size: arg)
				| 'field-size [set arg integer! | set arg pair! | | set arg none!] (field-size: arg)
				| 'label-size [set arg integer! | set arg pair! | | set arg none!] (label-size: arg)
				| 'text-size [set arg integer! | set arg pair! | | set arg none!] (text-size: arg)
				| 'pad [set arg pair! | set arg integer! | set arg paren!] (
					append-widget
					all [paren? arg arg: do arg]
					either integer? arg [
						arg: either left-to-right? [arg * sizes/cell] [negate arg * sizes/cell]
						either after-count = 1 [xy/y: xy/y + arg] [xy/x: xy/x + arg]
					] [xy: xy + arg]
				)
				| 'do set arg block! (view-face/init: make function! [face /local var] arg)
				| 'margin set arg pair! (append-widget margin-size: xy: arg * sizes/cell)
				| 'indent set arg integer! (
					append-widget
					indent-width: arg * sizes/cell
					xy/x: margin-size/x + indent-width
				)
				| 'space set arg pair! (append-widget gap-size: arg * sizes/cell)
				| 'tight (append-widget xy: margin-size: gap-size: 0x0)
				| 'at set arg pair! (append-widget xy: arg * sizes/cell + margin-size after-limit: 10000)
				| 'effect [set arg word! | set arg block!] (attribute-effect: arg)
				| 'options set arg block! (attribute-options: arg)
				| 'data set arg any-type! (attribute-data: either paren? arg [do arg] [arg])
				| 'edge set arg block! (attribute-edge: arg)
				| 'font set arg block! (attribute-font: arg)
				| 'para set arg block! (attribute-para: arg)
				| 'feel set arg block! (attribute-feel: arg)
				| 'on set arg block! (
					action-click: any [action-click select arg 'click]
					action-alt-click: any [action-alt-click select arg 'alt-click]
					action-dbl-click: any [action-dbl-click select arg 'dbl-click]
					action-away: select arg 'away
					action-edit: select arg 'edit
					action-focus: select arg 'focus
					action-key: select arg 'key
					action-over: select arg 'over
					action-resize: select arg 'resize
					action-scroll: select arg 'scroll
					action-time: select arg 'time
					action-unfocus: select arg 'unfocus
				)
				| 'on-alt-click set arg block! (action-alt-click: arg)
				| 'on-away set arg block! (action-away: arg)
				| 'on-click set arg block! (action-click: arg)
				| 'on-dbl-click set arg block! (action-dbl-click: arg)
				| 'on-edit set arg block! (action-edit: arg)
				| 'on-focus set arg block! (action-focus: arg)
				| 'on-key set arg block! (action-key: arg)
				| 'on-over set arg block! (action-over: arg)
				| 'on-resize set arg block! (action-resize: arg)
				| 'on-scroll set arg block! (action-scroll: arg)
				| 'on-time set arg block! (action-time: arg)
				| 'on-unfocus set arg block! (action-unfocus: arg)
				| 'rate [set arg integer! | set arg time!] (attribute-rate: arg)
				| 'text-color set arg tuple! (attribute-text-color: arg)
				| 'bold (attribute-text-style: 'bold)
				| 'italic (attribute-text-style: 'italic)
				| 'underline (attribute-text-style: 'underline)
				| [set arg integer! | set arg pair!] (attribute-size: arg)
				| set arg issue! (attribute-span: sort arg)
				| set arg string! (attribute-text: arg)
				| [set arg tuple! | set arg none!] (attribute-color: arg)
				| set arg image! (attribute-image: arg)
				| set arg file! (widget attribute-image: either widget = 'icon [arg] [load arg])
				| set arg url! (attribute-data: arg)
				| set arg block! (
					case [
						none? action-click [action-click: arg]
						none? action-alt-click [action-alt-click: arg]
						none? action-dbl-click [action-dbl-click: arg]
					]
				)
				| set arg logic! (attribute-show?: arg)
				| set arg char! (attribute-keycode: arg)
				| set arg set-word! (append-widget word: :arg)
				| set arg word! (append-widget widget: arg)
			]]
	]

	append-widget

	;	any main init to do?
	view-face/init view-face ; execute
	view-face/init: none ; free
	view-face/size: view-face/span-size: margin-size + as-pair max-width max-height

	unless only [
		;	any post-size span adjustment required?
		foreach face view-face/pane [span-init face view-face/size margin-size]
		;	center-face if no offset provided
		all [
			zero? view-face/offset
			view-face/offset: max 0x0 screen*/size - view-face/size / 2
		]
	]

	view-face
]