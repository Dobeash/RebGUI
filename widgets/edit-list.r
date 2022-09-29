edit-list: make drop-list [
	options: {
		USAGE:
			edit-list "1" data [1 2 3]
			edit-list data ["One" "Two" "Three"]
			edit-list data ctx-rebgui/locale*/colors

		DESCRIPTION:
			Editable single column modal selection list.
			At runtime face/text contains current selection.
	}
	text: ""
	color: colors/edit
	effect: none
	data: []
	edge: default-edge
	para: make default-para [margin: as-pair sizes/line + 2 2]
	feel: make edit/feel bind [
		over: make function! [face into pos /state] []
		engage: make function! [face action event /local start end total visible fd pf] [
			switch action [
				key [
					if event/key = #"^M" [
						edit-text face event
						hide-popup
						edit/unfocus
						exit
					]
					if event/key = 'down [
						either view*/pop-face [set-focus view*/pop-face] [face/pane/feel/engage face/pane action event]
						exit
					]
					prev-caret: index? view*/caret
					face/text: any [face/hidden-text head view*/caret]
					view*/caret: any [face/hidden-caret view*/caret]
					all [view*/highlight-start view*/highlight-start: at face/text index? view*/highlight-start]
					all [view*/highlight-end view*/highlight-end: at face/text index? view*/highlight-end]
					edit-text face event
					face/hidden-text: copy face/text
					face/hidden-caret: at face/hidden-text index? view*/caret
					fd: copy []
					if find face/text edit/letter [; no auto-complete for numbers
						foreach ln sort face/data [
							if find/match ln: form ln face/text [
								face/text: copy ln
								view*/caret: at face/text index? view*/caret
								unless char? event/key [
									view*/caret: at face/text prev-caret
									edit-text face event
									face/hidden-text: copy face/text
									face/hidden-caret: at face/hidden-text index? view*/caret
								]
							]
							if find/match ln face/hidden-text [
								insert tail fd ln
							]
						]
					]
					unless empty? fd [
;					either not empty? fd [
						either none? view*/pop-face [
							face/pane/feel/engage/filter-data face/pane 'down none fd
						] [
							pf: view*/pop-face
							pf/data: copy fd
							pf/pane/1/size/y: pf/size/y: sizes/line * (length? fd)
							pf/lines: to integer! pf/size/y / sizes/line
							pf/rows: length? fd
							;check-editable
							show pf
						]
;					] [
;						hide-popup
					]
					show face
				]
				down [
					either event/double-click [
						all [view*/caret not empty? view*/caret current-word view*/caret]
					] [
						either face <> view*/focal-face [set-focus face] [unlight-text]
						view*/caret: offset-to-caret face event/offset
						show face
					]
				]
				over [
					unless equal? view*/caret offset-to-caret face event/offset [
						unless view*/highlight-start [view*/highlight-start: view*/caret]
						view*/highlight-end: view*/caret: offset-to-caret face event/offset
						show face
					]
				]
			]
		]
	] in edit 'self
	caret: none
]