# Widget Reference

Each of the following sections describes a function in detail with one or more of the following:

* **Usage:** one or more code samples demonstrating an aspect of the widget's use.
* **Description:** brief description of what the widget is and any other points of interest.
* **Options:** allowable specification options.
* **Attributes:** `rebface` attributes with a value other than `none!` (the default).
* **Predefined feels:** feel function(s) that have already been defined.
* **Predefined actions:** action function(s) that have already been defined.
* **Extended attributes:** attributes, other than functions, not present in the standard `rebface` object.
* **Accessor functions:** functions specific to the widget.

## anim

	USAGE:
		anim data [ctx-rebgui/images/help ctx-rebgui/images/info]
		anim data [%img1.png %img2.png %img3.png]
		anim data [img1 img2 img3] rate 2

	DESCRIPTION:
		Cycles a set of images at a specified rate.

	ATTRIBUTES:
		size            -1x-1
		effect          fit
		rate            1

	PREDEFINED ACTIONS:
		on-time

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [anim.r](widgets/anim.r)

## area

	USAGE:
		area
		area "Text" -1
		area "Text" 50x-1

	DESCRIPTION:
		Editable text area with wrapping and scroller.

	ATTRIBUTES:
		size            50x25
		text            ""
		color           255.255.255
		edge            object!
		font            object!
		para            object!

	PREDEFINED FEELS:
		redraw
		engage

	PREDEFINED ACTIONS:
		on-resize
		on-scroll

	EXTENDED ATTRIBUTES:
		esc             none
		caret           none
		undo            block!
		text-y          none
		key-scroll?     false
		init            function!

Source code: [area.r](widgets/area.r)

## arrow

	USAGE:
		arrow
		arrow 10
		arrow data 'up
		arrow data 'down
		arrow data 'left
		arrow data 'right

	DESCRIPTION:
		An arrow (default down) on a square button face with height set to width.

	ATTRIBUTES:
		size            5x-1
		effect          block!
		data            down
		edge            object!

	PREDEFINED FEELS:
		over
		engage

	EXTENDED ATTRIBUTES:
		old-color       none
		init            function!

Source code: [arrow.r](widgets/arrow.r)

## bar

	USAGE:
		bar 100

	DESCRIPTION:
		A thin bar used to separate widgets.
		Defaults to maximum display width.

	ATTRIBUTES:
		size            -1x-1
		color           112.112.112

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [bar.r](widgets/bar.r)

## box

	USAGE:
		box red

	DESCRIPTION:
		The most basic of widgets, a rectangular area.

	ATTRIBUTES:
		size            25x25

Source code: [box.r](widgets/box.r)

## btn

	USAGE:
		btn "Hello"
		btn -1 "Go!"
		btn "Click me!" [print "click"]

	DESCRIPTION:
		Performs action when clicked.

	ATTRIBUTES:
		size            -1x5
		text            ""
		effect          block!
		edge            object!
		font            object!

	PREDEFINED FEELS:
		over
		engage

	EXTENDED ATTRIBUTES:
		old-color       none
		init            function!

Source code: [btn.r](widgets/btn.r)

## button

	USAGE:
		button "Hello"
		button -1 "Go!"
		button "Click me!" [print "click"]

	DESCRIPTION:
		Performs action when clicked.

	ATTRIBUTES:
		size            15x5
		text            ""
		effect          block!
		font            object!

	PREDEFINED FEELS:
		over
		engage

	PREDEFINED ACTIONS:
		on-resize

	EXTENDED ATTRIBUTES:
		init            function!
		old-color       none

Source code: [button.r](widgets/button.r)

## calendar

	USAGE:
		calendar
		calendar data 1-Jan-2000

	DESCRIPTION:
		Used to select a date, with face/data set to current selection.
		Default selection is now/date.

	ATTRIBUTES:
		size            56x40
		color           255.255.255
		edge            object!

	PREDEFINED FEELS:
		redraw

	EXTENDED ATTRIBUTES:
		date            none
		init            function!

Source code: [calendar.r](widgets/calendar.r)

## chat

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

	ATTRIBUTES:
		size            200x100
		pane            block!
		data            block!
		edge            object!

	PREDEFINED ACTIONS:
		on-resize

	EXTENDED ATTRIBUTES:
		height          0
		rows            0
		limit           none
		init            function!

	ACCESSOR FUNCTIONS:
		APPEND-MESSAGE user user-color msg msg-color date /no-show row
		SET-USER-COLOR id color
		SET-MESSAGE-TEXT id string
		SET-MESSAGE-COLOR id color
		REDRAW /no-show

Source code: [chat.r](widgets/chat.r)

## check

	USAGE:
		check "Option"
		check "Option" data true
		check "Option" data false

	DESCRIPTION:
		Bistate check-box with a tick for Yes and empty for No.

	ATTRIBUTES:
		size            -1x5
		text            ""
		effect          block!
		font            object!
		para            object!

	PREDEFINED FEELS:
		over
		engage

	EXTENDED ATTRIBUTES:
		p1              2x6
		p2              10x14
		init            function!

Source code: [check.r](widgets/check.r)

## check-group

	USAGE:
		check-group data ["Option-1" true "Option-2" false "Option-3" none]

	DESCRIPTION:
		Group of check boxes.
		Alignment is vertical unless height is specified as line height.
		At runtime face/data is a block of logic (or none) indicating state of each check box.

	ATTRIBUTES:
		size            50x-1
		pane            block!

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [check-group.r](widgets/check-group.r)

## drop-list

	USAGE:
		drop-list "1" data [1 2 3]
		drop-list data ["One" "Two" "Three"]
		drop-list data ctx-rebgui/locale*/colors

	DESCRIPTION:
		Single column modal selection list.
		At runtime face/text contains current selection.

	ATTRIBUTES:
		size            25x5
		text            ""
		effect          block!
		data            block!
		edge            object!
		font            object!

	PREDEFINED FEELS:
		over
		engage

	PREDEFINED ACTIONS:
		on-resize
		on-unfocus

	EXTENDED ATTRIBUTES:
		hidden-caret    none
		hidden-text     none
		init            function!

	ACCESSOR FUNCTIONS:
		PICKED

Source code: [drop-list.r](widgets/drop-list.r)

## edit-list

	USAGE:
		edit-list "1" data [1 2 3]
		edit-list data ["One" "Two" "Three"]
		edit-list data ctx-rebgui/locale*/colors

	DESCRIPTION:
		Editable single column modal selection list.
		At runtime face/text contains current selection.

	ATTRIBUTES:
		size            25x5
		text            ""
		color           255.255.255
		data            block!
		edge            object!
		font            object!
		para            object!

	PREDEFINED FEELS:
		over
		engage

	PREDEFINED ACTIONS:
		on-resize
		on-unfocus

	EXTENDED ATTRIBUTES:
		hidden-caret    none
		hidden-text     none
		init            function!
		caret           none

	ACCESSOR FUNCTIONS:
		PICKED

Source code: [edit-list.r](widgets/edit-list.r)

## field

	USAGE:
		field
		field -1 "String"

	DESCRIPTION:
		Editable text field with no text wrapping.

	ATTRIBUTES:
		size            50x5
		text            ""
		color           255.255.255
		edge            object!
		font            object!
		para            object!

	PREDEFINED FEELS:
		engage

	EXTENDED ATTRIBUTES:
		init            function!
		esc             none
		caret           none
		undo            block!

Source code: [field.r](widgets/field.r)

## group-box

	USAGE:
		group-box "Title" data [field field]

	DESCRIPTION:
		A static widget used to group widgets within a bounded container.

	ATTRIBUTES:
		size            -1x-1
		text            ""
		effect          block!
		font            object!
		para            object!

	PREDEFINED FEELS:
		redraw

	PREDEFINED ACTIONS:
		on-resize

	EXTENDED ATTRIBUTES:
		group           none
		init            function!

Source code: [group-box.r](widgets/group-box.r)

## heading

	USAGE:
		heading "A text heading."

	DESCRIPTION:
		Large text.

	ATTRIBUTES:
		size            -1x7
		text            ""
		font            object!

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [heading.r](widgets/heading.r)

## icon

	USAGE:
		icon %actions/go-up.png

	DESCRIPTION:
		An icon.

	ATTRIBUTES:
		size            5x5
		pane            block!
		effect          block!
		data            down
		edge            object!

	PREDEFINED FEELS:
		over
		engage

	EXTENDED ATTRIBUTES:
		old-color       none
		init            function!

Source code: [icon.r](widgets/icon.r)

## image

	USAGE:
		image %icons/Tango-feet.png
		image logo
		image logo effect [crop 10x10 50x50]

	DESCRIPTION:
		An image.

	ATTRIBUTES:
		size            -1x-1
		effect          fit

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [image.r](widgets/image.r)

## label

	USAGE:
		label "A text label."

	DESCRIPTION:
		Label text.

	ATTRIBUTES:
		size            25x5
		text            ""
		font            object!

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [label.r](widgets/label.r)

## led

	USAGE:
		led "Option"
		led "Option" data true
		led "Option" data false
		led "Option" data none

	DESCRIPTION:
		Tristate indicator box with colors representing Yes & No, and empty being Unknown.

	ATTRIBUTES:
		size            -1x5
		effect          block!
		font            object!
		para            object!

	PREDEFINED FEELS:
		redraw

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [led.r](widgets/led.r)

## led-group

	USAGE:
		led-group data ["Option-1" true "Option-2" false "Option-3" none]

	DESCRIPTION:
		Group of LED indicators.
		Alignment is vertical unless height is specified as line height.
		At runtime face/data is a block of logic (or none) indicating state of each LED indicator.

	ATTRIBUTES:
		size            50x-1
		pane            block!

	PREDEFINED FEELS:
		redraw

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [led-group.r](widgets/led-group.r)

## link

	USAGE:
		link
		link http://www.dobeash.com
		link "RebGUI" http://www.dobeash.com/rebgui

	DESCRIPTION:
		Hypertext link.

	ATTRIBUTES:
		size            -1x5
		font            object!

	PREDEFINED FEELS:
		over
		engage

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [link.r](widgets/link.r)

## menu

	USAGE:
		menu data ["Item-1" ["Choice 1" [alert "1"] "Choice 2" [alert "2"] ] "Item-2" [] ]

	DESCRIPTION:
		Simple one-level text-only menu system.

	ATTRIBUTES:
		size            100x5
		pane            block!
		color           207.207.207
		effect          block!
		edge            object!
		font            object!

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [menu.r](widgets/menu.r)

## panel

	USAGE:
		panel data [after 1 field field]

	DESCRIPTION:
		A static widget used to group widgets within a container.

	ATTRIBUTES:
		size            -1x-1
		effect          block!

	PREDEFINED ACTIONS:
		on-resize

	EXTENDED ATTRIBUTES:
		group           none
		init            function!

Source code: [panel.r](widgets/panel.r)

## password

	USAGE:
		password
		password "Secret"

	DESCRIPTION:
		Editable password field with text displayed as a progress bar.

	ATTRIBUTES:
		size            50x5
		text            ""
		color           255.255.255
		effect          block!
		edge            object!
		font            object!
		para            object!

	PREDEFINED FEELS:
		engage

	PREDEFINED ACTIONS:
		on-edit

	EXTENDED ATTRIBUTES:
		init            function!
		esc             none
		caret           none
		undo            block!

Source code: [password.r](widgets/password.r)

## pill

	USAGE:
		pill red

	DESCRIPTION:
		A rectangular area with rounded corners.

	ATTRIBUTES:
		size            10x10
		effect          block!

	PREDEFINED ACTIONS:
		on-resize

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [pill.r](widgets/pill.r)

## progress

	USAGE:
		progress
		progress data .5

	DESCRIPTION:
		A horizontal progress indicator.
		At runtime face/data ranges from 0 to 1 indicating percentage.

	ATTRIBUTES:
		size            50x5
		effect          block!
		data            0
		edge            object!

	PREDEFINED FEELS:
		redraw

	PREDEFINED ACTIONS:
		on-resize

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [progress.r](widgets/progress.r)

## radio-group

	USAGE:
		radio-group data ["Option A" "Option B"]
		radio-group data [2 "On" "Off"]

	DESCRIPTION:
		Group of mutually exclusive radio buttons.
		Alignment is vertical unless height is specified as line height.
		An integer provided as the first entry in the block indicates the default selection.

	ATTRIBUTES:
		size            -1x-1
		pane            block!

	EXTENDED ATTRIBUTES:
		picked          none
		init            function!

	ACCESSOR FUNCTIONS:
		SELECTED
		SELECT-ITEM item

Source code: [radio-group.r](widgets/radio-group.r)

## scroll-panel

	USAGE:
		scroll-panel data [sheet]

	DESCRIPTION:
		A panel used to group widgets within a scrollable container.

	OPTIONS:
		'offset keeps the original offset

	ATTRIBUTES:
		size            50x50
		pane            block!
		edge            object!

	PREDEFINED ACTIONS:
		on-click
		on-resize
		on-scroll

	EXTENDED ATTRIBUTES:
		p1              none
		p2              none
		p3              none
		p4              none
		sld-offset      0x0
		init            function!

Source code: [scroll-panel.r](widgets/scroll-panel.r)

## sheet

	USAGE:
		sheet
		sheet options [size 3x3 width 2]
		sheet options [size 3x3 widths [2 3 4] ]
		sheet data [A1 1 A2 2 A3 "=A1 + A2"]

	DESCRIPTION:
		Simple spreadsheet, based on rebocalc.r, with formulas calculated left to right, top to bottom.
		A cell is either a scalar value, string, or a formula starting with "=".
		Scalar values are automatically right-justified, series values left-justified.
		Remember to put spaces between each item in a formula and use () where needed.

	OPTIONS:
		'size specifies number of columns and rows
		'width specifies cell width in relation to cell height
		'widths specifies n cell widths

	ATTRIBUTES:
		size            -1x-1
		pane            block!
		color           207.207.207
		data            block!

	EXTENDED ATTRIBUTES:
		group           none
		init            function!

	ACCESSOR FUNCTIONS:
		LOAD-DATA dat
		SAVE-DATA
		ENTER face
		COMPUTE

Source code: [sheet.r](widgets/sheet.r)

## slider

	USAGE:
		slider []
		slider data .5 [print face/data]

	DESCRIPTION:
		A slider control. Its size determines whether it is vertical or horizontal.
		At runtime face/data ranges from 0 to 1 indicating percentage.

	OPTIONS:
		[ratio n] where n indicates the initial dragger size

	ATTRIBUTES:
		size            5x50
		pane            block!
		effect          block!
		data            0
		edge            object!
		font            object!

	PREDEFINED FEELS:
		redraw
		over
		engage

	EXTENDED ATTRIBUTES:
		ratio           0.1
		step            5E-2
		axis            2
		state           none
		init            function!

	ACCESSOR FUNCTIONS:
		SET-DATA new
		UPDATE-DATA offset

Source code: [slider.r](widgets/slider.r)

## spinner

	USAGE:
		spinner
		spinner options [$1 $10 $1] data $5

	DESCRIPTION:
		Similar to a field, with arrows to increment/decrement a value by a nominated step amount.

	OPTIONS:
		[min max step] block of minimum, maximum and step amounts

	ATTRIBUTES:
		size            20x5
		pane            block!
		text            ""
		color           255.255.255
		edge            object!
		font            object!
		para            object!

	PREDEFINED FEELS:
		engage

	PREDEFINED ACTIONS:
		on-resize
		on-scroll
		on-unfocus

	EXTENDED ATTRIBUTES:
		init            function!
		esc             none
		caret           none
		undo            block!

Source code: [spinner.r](widgets/spinner.r)

## splitter

	USAGE:
		area splitter area

	DESCRIPTION:
		Placed between two widgets on the same row or column.
		Allows both to be resized by dragging the splitter left/right or up/down respectively.
		Its size determines whether it is vertical or horizontal.

	ATTRIBUTES:
		size            2x25
		effect          block!
		edge            object!
		font            object!

	PREDEFINED FEELS:
		redraw
		over
		engage

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [splitter.r](widgets/splitter.r)

## tab-panel

	USAGE:
		tab-panel data ["A" [field] "B" [field] "C" [field] ]
		tab-panel data ["1" [field] action [face/color: red] "2" [field] ]

	DESCRIPTION:
		A panel with a set of tabs.
		Each tab spec may be preceded by an action block spec.

	OPTIONS:
		'action do action of initial tab (if any)
		[tab n] where n specifies tab to initially open with (default 1)
		no-tabs do not display tabs (overlay mode)

	ATTRIBUTES:
		size            -1x-1
		pane            block!

	EXTENDED ATTRIBUTES:
		group           none
		tabs            0
		init            function!

	ACCESSOR FUNCTIONS:
		SELECTED
		SELECT-TAB num
		REPLACE-TAB num block /title text

Source code: [tab-panel.r](widgets/tab-panel.r)

## table

	USAGE:
		table options ["Name" left .5 "Age" right .5] data ["Bob" 32 "Pete" 45 "Jack" 29]

	DESCRIPTION:
		Columns and rows of values formatted according to a header definition block.

	OPTIONS:
		'multi allows multiple rows to be selected at once
		'no-sort disables column sorting
		'no-resize disables column resizing
		'fixed-sort limits sorting to first column only

	ATTRIBUTES:
		size            50x25
		pane            block!
		color           255.255.255
		data            block!
		edge            object!

	PREDEFINED ACTIONS:
		on-resize

	EXTENDED ATTRIBUTES:
		picked          block!
		widths          block!
		aligns          block!
		cols            none
		init            function!

	ACCESSOR FUNCTIONS:
		REDRAW
		SELECTED
		ROWS
		ADD-ROW row /position pos
		REMOVE-ROW row
		ALTER-ROW row values
		SELECT-ROW row /no-action

Source code: [table.r](widgets/table.r)

## text

	USAGE:
		text "A text string."
		text "Blue text" text-color blue
		text "Bold text" bold
		text "Italic text" italic
		text "Underline text" underline

	DESCRIPTION:
		Normal text.

	ATTRIBUTES:
		size            -1x5
		text            ""
		font            object!
		para            object!

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [text.r](widgets/text.r)

## text-list

	USAGE:
		text-list data ["One" "Two"]
		text-list data ctx-rebgui/locale*/colors
		text-list data [1 2]  [print face/selected]

	DESCRIPTION:
		A single column list with a scroller.

	OPTIONS:
		'multi allows multiple rows to be selected at once

	ATTRIBUTES:
		size            50x25
		color           255.255.255
		data            block!
		edge            object!

	PREDEFINED ACTIONS:
		on-resize

	EXTENDED ATTRIBUTES:
		picked          block!
		init            function!

	ACCESSOR FUNCTIONS:
		REDRAW
		SELECTED
		ROWS
		SELECT-ROW row /no-action

Source code: [text-list.r](widgets/text-list.r)

## title-group

	USAGE:
		title-group %icons/setup.png data "Title" "Body"

	DESCRIPTION:
		A title and text with an optional image to the left.
		If an image is specified then height is set to image height.

	ATTRIBUTES:
		size            100x100
		font            object!

	EXTENDED ATTRIBUTES:
		init            function!

Source code: [title-group.r](widgets/title-group.r)

## toggle

	USAGE:
		toggle data ["A" "B"]

	DESCRIPTION:
		Toggles state when clicked.

	OPTIONS:
		'on starts selected

	ATTRIBUTES:
		size            15x5
		text            ""
		effect          block!
		edge            object!
		font            object!

	PREDEFINED FEELS:
		over
		engage

	EXTENDED ATTRIBUTES:
		old-color       none
		init            function!
		texts           none

Source code: [toggle.r](widgets/toggle.r)

## tool-bar

	USAGE:
		tool-bar data [arrow button field]
		tool-bar data [icon "Open" %actions/document-open.png [] ]

	DESCRIPTION:
		A toolbar with small margins (2x1) and minimal spacing (1x1).

	ATTRIBUTES:
		size            -1x7
		effect          block!
		edge            object!
		font            object!

	PREDEFINED FEELS:
		detect

	EXTENDED ATTRIBUTES:
		group           none
		.tip            none
		init            function!

Source code: [tool-bar.r](widgets/tool-bar.r)

## tree

	USAGE:
		tree data ["Pets" ["Cat" "Dog"] "Numbers" [1 2 3] ]

	DESCRIPTION:
		Values arranged in a collapsible hierarchy.

	OPTIONS:
		'only returns item not full path

	ATTRIBUTES:
		size            50x25
		pane            block!
		color           255.255.255
		data            block!
		edge            object!

	PREDEFINED ACTIONS:
		on-resize

	EXTENDED ATTRIBUTES:
		picked          block!
		.data           block!
		.tabs           block!
		.data-path      block!
		.data-list      block!
		init            function!

	ACCESSOR FUNCTIONS:
		REDRAW
		SELECTED
		ROWS
		SELECT-ROW row /no-action
		BUILD-TREE string items

Source code: [tree.r](widgets/tree.r)