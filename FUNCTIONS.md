# Function Reference

Each of the following sections describes a function in detail with one or more of the following:

* **Usage:** complete function syntax.
* **Description:** brief description of what the function does.
* **Arguments:** values, and optionally their type(s), expected by the function.
* **Refinements:** flags & optional arguments that control or modify the function's behavior.

## clear-text

	USAGE:
		CLEAR-TEXT face /no-show /focus

	DESCRIPTION:
		Clear text attribute of a widget or block of widgets.

	ARGUMENTS:
		face [object! block!]

	REFINEMENTS:
		/no-show                        -- Don't show
		/focus

Source code: [clear-text.r](functions/clear-text.r)

## disable

	USAGE:
		DISABLE face

	DESCRIPTION:
		Disable a widget.

	ARGUMENTS:
		face [object! block!]

Source code: [disable.r](functions/disable.r)

## display

	USAGE:
		DISPLAY title spec /dialog /parent /close closer /offset xy /maximize /no-wait

	DESCRIPTION:
		Displays widgets in a centered window with a title.

	ARGUMENTS:
		title [string!]                 -- Window title
		spec [block!]                   -- Block of widgets, attributes and keywords

	REFINEMENTS:
		/dialog                         -- Modal dialog with /parent & /close options
		/parent                         -- Force parent to be last window (default is first)
		/close closer [block!]          -- Handle window close event
		/offset xy [pair!]              -- Offset of window on screen
		/maximize                       -- Maximize window
		/no-wait                        -- Don't wait if a dialog (used by request-progress)

Source code: [display.r](functions/display.r)

## do-events

	USAGE:
		DO-EVENTS /email address

	DESCRIPTION:
		Process all Display events.

	REFINEMENTS:
		/email address [email!]         -- Specify an email address to send errors to.

Source code: [do-events.r](functions/do-events.r)

## enable

	USAGE:
		ENABLE face

	DESCRIPTION:
		Enable a widget.

	ARGUMENTS:
		face [object! block!]

Source code: [enable.r](functions/enable.r)

## examine

	USAGE:
		EXAMINE widget /indent /no-print

	DESCRIPTION:
		Prints information about widgets and attributes.

	ARGUMENTS:
		'widget

	REFINEMENTS:
		/indent                         -- Indent output as an MD2 ready string
		/no-print                       -- Do not print output to console

Source code: [examine.r](functions/examine.r)

## get-fonts

	USAGE:
		GET-FONTS /cache file

	DESCRIPTION:
		Obtain list of fonts on supported platforms.

	REFINEMENTS:
		/cache file [file!]             -- Obtain fonts from file

Source code: [get-fonts.r](functions/get-fonts.r)

## get-values

	USAGE:
		GET-VALUES face /type

	DESCRIPTION:
		Gets values from input widgets within a display or grouping widget.

	ARGUMENTS:
		face [object!]                  -- Display face

	REFINEMENTS:
		/type                           -- Precede each value with its type

Source code: [get-values.r](functions/get-values.r)

## hide-popup

	USAGE:
		HIDE-POPUP

	DESCRIPTION:
		Undisplay current modal dialog/popup.

Source code: [hide-popup.r](functions/hide-popup.r)

## in-widget

	USAGE:
		IN-WIDGET face type

	DESCRIPTION:
		Find matching widget types in a widget's pane.

	ARGUMENTS:
		face [object!]                  -- Widget
		type [word!]                    -- Widget type to find

Source code: [in-widget.r](functions/in-widget.r)

## layout

	USAGE:
		LAYOUT spec /only

	DESCRIPTION:
		Parse/layout a block of widgets, attributes and keywords.

	ARGUMENTS:
		spec [block!]                   -- Block of widgets, attributes and keywords

	REFINEMENTS:
		/only                           -- Do not change face offset

Source code: [layout.r](functions/layout.r)

## set-color

	USAGE:
		SET-COLOR face color /no-show /deselect

	DESCRIPTION:
		Set and show a widget's color attribute.

	ARGUMENTS:
		face [object!]
		color [tuple! none!]

	REFINEMENTS:
		/no-show                        -- Don't show
		/deselect                       -- Restore to base color

Source code: [set-color.r](functions/set-color.r)

## set-data

	USAGE:
		SET-DATA face data /no-show

	DESCRIPTION:
		Set and show a widget's data attribute.

	ARGUMENTS:
		face [object!]
		data [any-type!]

	REFINEMENTS:
		/no-show                        -- Don't show

Source code: [set-data.r](functions/set-data.r)

## set-focus

	USAGE:
		SET-FOCUS face /caret

	DESCRIPTION:
		Set and show widget focus.

	ARGUMENTS:
		face [object!]

	REFINEMENTS:
		/caret

Source code: [set-focus.r](functions/set-focus.r)

## set-locale

	USAGE:
		SET-LOCALE language

	DESCRIPTION:
		Dynamically set/change locale.

	ARGUMENTS:
		language [string! none!]

Source code: [set-locale.r](functions/set-locale.r)

## set-state

	USAGE:
		SET-STATE face state /no-show

	DESCRIPTION:
		Set and show a widget's state.

	ARGUMENTS:
		face [object!]
		state [logic!]

	REFINEMENTS:
		/no-show                        -- Don't show

Source code: [set-state.r](functions/set-state.r)

## set-text

	USAGE:
		SET-TEXT face text /caret /no-show /focus

	DESCRIPTION:
		Set and show a widget's text attribute.

	ARGUMENTS:
		face [object!]                  -- Widget
		text [any-type!]                -- Text

	REFINEMENTS:
		/caret                          -- Insert at cursor position (tail if none)
		/no-show                        -- Don't show
		/focus

Source code: [set-text.r](functions/set-text.r)

## set-text-color

	USAGE:
		SET-TEXT-COLOR face color /no-show

	DESCRIPTION:
		Set and show a widget's font color attribute.

	ARGUMENTS:
		face [object!]
		color [tuple! none!]

	REFINEMENTS:
		/no-show                        -- Don't show

Source code: [set-text-color.r](functions/set-text-color.r)

## set-texts

	USAGE:
		SET-TEXTS faces text /no-show

	DESCRIPTION:
		Set and show text attribute of a block of widgets.

	ARGUMENTS:
		faces [block!]                  -- Widgets
		text [any-type!]                -- Text or block of text

	REFINEMENTS:
		/no-show                        -- Don't show

Source code: [set-texts.r](functions/set-texts.r)

## set-title

	USAGE:
		SET-TITLE face title

	DESCRIPTION:
		Set and show window title.

	ARGUMENTS:
		face [object!]                  -- Any face in the window
		title [string!]                 -- Window bar title

Source code: [set-title.r](functions/set-title.r)

## show-popup

	USAGE:
		SHOW-POPUP face /window window-face

	DESCRIPTION:
		face

	REFINEMENTS:
		/window window-face [object!]   -- Parent pane to appear in

Source code: [show-popup.r](functions/show-popup.r)

## translate

	USAGE:
		TRANSLATE text

	DESCRIPTION:
		Dynamically translate a string or block of strings.

	ARGUMENTS:
		text                            -- String (or block of strings) to translate

Source code: [translate.r](functions/translate.r)

## undisplay

	USAGE:
		UNDISPLAY face

	DESCRIPTION:
		Closes parent display of face.

	ARGUMENTS:
		face [object!]

Source code: [undisplay.r](functions/undisplay.r)