# Requestor Reference

Each of the following sections describes a function in detail with one or more of the following:

* **Usage:** complete function syntax.
* **Description:** brief description of what the function does.
* **Arguments:** values, and optionally their type(s), expected by the function.
* **Refinements:** flags & optional arguments that control or modify the function's behavior.

## alert

	USAGE:
		ALERT value /title text

	DESCRIPTION:
		Flashes an alert message to the user. Waits for a user response.
		ALERT is a function value.

	ARGUMENTS:
		value -- Value to display (Type: any-type)

	REFINEMENTS:
		/title
			text -- (Type: string)

Source code: [alert.r](requestors/alert.r)

## confirm

	USAGE:
		CONFIRM question /title text

	DESCRIPTION:
		Confirms a user choice.
		CONFIRM is a function value.

	ARGUMENTS:
		question -- Prompt to user (Type: string)

	REFINEMENTS:
		/title
			text -- (Type: string)

Source code: [confirm.r](requestors/confirm.r)

## editor

	USAGE:
		EDITOR file /title text /size cells

	DESCRIPTION:
		Displays text in an editable area with option to save.
		EDITOR is a function value.

	ARGUMENTS:
		file -- (Type: file string)

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/size
			cells -- Size of edit area in cells (Type: pair)

Source code: [editor.r](requestors/editor.r)

## flash

	USAGE:
		FLASH value /title text

	DESCRIPTION:
		Flashes a message to the user and continues.
		FLASH is a function value.

	ARGUMENTS:
		value -- Value to display (Type: any-type)

	REFINEMENTS:
		/title
			text -- (Type: string)

Source code: [flash.r](requestors/flash.r)

## request

	USAGE:
		REQUEST prompt /title text /ok /confirm /type icon

	DESCRIPTION:
		Requests an answer to a simple question.
		REQUEST is a function value.

	ARGUMENTS:
		prompt -- (Type: string)

	REFINEMENTS:
		/title
			text -- (Type: string)
		/ok
		/confirm
		/type
			icon -- Valid values are: alert, help, info, stop (Type: word)

Source code: [request.r](requestors/request.r)

## request-about

	USAGE:
		REQUEST-ABOUT product version copyright /url link

	DESCRIPTION:
		Requests an About dialog.
		REQUEST-ABOUT is a function value.

	ARGUMENTS:
		product -- Product name (Type: string)
		version -- Product version (Type: tuple)
		copyright -- Copyright notice (Type: string)

	REFINEMENTS:
		/url
			link -- Product website (Type: string url)

Source code: [request-about.r](requestors/request-about.r)

## request-calc

	USAGE:
		REQUEST-CALC /title text /stay

	DESCRIPTION:
		Requests a calculation.
		REQUEST-CALC is a function value.

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/stay -- Don't exit on =

Source code: [request-calc.r](requestors/request-calc.r)

## request-char

	USAGE:
		REQUEST-CHAR /title text /font name

	DESCRIPTION:
		Requests a character.
		REQUEST-CHAR is a function value.

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/font
			name -- Font to use (Type: string)

Source code: [request-char.r](requestors/request-char.r)

## request-color

	USAGE:
		REQUEST-COLOR /title text /color clr

	DESCRIPTION:
		Requests a color.
		REQUEST-COLOR is a function value.

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/color
			clr -- Default color (Type: tuple)

Source code: [request-color.r](requestors/request-color.r)

## request-date

	USAGE:
		REQUEST-DATE /title text /date dt

	DESCRIPTION:
		Requests a date.
		REQUEST-DATE is a function value.

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/date
			dt -- Initial date to show (default is today) (Type: date)

Source code: [request-date.r](requestors/request-date.r)

## request-dir

	USAGE:
		REQUEST-DIR /title text /path dir /only

	DESCRIPTION:
		Requests a directory.
		REQUEST-DIR is a function value.

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/path
			dir -- Set starting directory (Type: file)
		/only -- Only allow new folder at root

Source code: [request-dir.r](requestors/request-dir.r)

## request-email

	USAGE:
		REQUEST-EMAIL /title text /default settings

	DESCRIPTION:
		Requests email settings.
		REQUEST-EMAIL is a function value.

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/default
			settings -- Default user, address, SMTP and POP settings (Type: block)

Source code: [request-email.r](requestors/request-email.r)

## request-error

	USAGE:
		REQUEST-ERROR error

	DESCRIPTION:
		Displays an error with send and exit options.
		REQUEST-ERROR is a function value.

	ARGUMENTS:
		error -- (Type: error string)

Source code: [request-error.r](requestors/request-error.r)

## request-file

	USAGE:
		REQUEST-FILE /title text /path dir /save /filter mask /default file

	DESCRIPTION:
		Requests a file.
		REQUEST-FILE is a function value.

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/path
			dir -- Set starting directory (Type: file)
		/save -- Request file for saving, otherwise loading
		/filter
			mask -- Coerce suffix if file! (Type: file block)
		/default
			file -- (Type: file)

Source code: [request-file.r](requestors/request-file.r)

## request-font

	USAGE:
		REQUEST-FONT /title text /object

	DESCRIPTION:
		Requests a font name, returning a string.
		REQUEST-FONT is a function value.

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/object -- Adds style, size and align selectors (returns font! object!)

Source code: [request-font.r](requestors/request-font.r)

## request-list

	USAGE:
		REQUEST-LIST items /title text /prompt string /ok

	DESCRIPTION:
		Requests a selection from a list.
		REQUEST-LIST is a function value.

	ARGUMENTS:
		items -- List of items to display. (Type: block)

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/prompt
			string -- Prompt text (Type: string)
		/ok

Source code: [request-list.r](requestors/request-list.r)

## request-menu

	USAGE:
		REQUEST-MENU face menu /width x /offset xy

	DESCRIPTION:
		Requests a menu choice.
		REQUEST-MENU is a function value.

	ARGUMENTS:
		face -- Widget to appear in relation to (Type: object)
		menu -- Label/Action block pairs (Type: block)

	REFINEMENTS:
		/width
			x -- Width in pixels (defaults to 25 units) (Type: integer)
		/offset
			xy -- Offset relative to widget (defaults to top right) (Type: pair)

Source code: [request-menu.r](requestors/request-menu.r)

## request-pass

	USAGE:
		REQUEST-PASS /title text /user username /pass password /check rules /only /verify

	DESCRIPTION:
		Requests a username and password.
		REQUEST-PASS is a function value.

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/user
			username -- Default username (Type: string)
		/pass
			password -- Default password (Type: string)
		/check
			rules -- Rules to test password against (fails if string returned) (Type: block)
		/only -- Password only
		/verify -- Verify password

Source code: [request-pass.r](requestors/request-pass.r)

## request-progress

	USAGE:
		REQUEST-PROGRESS steps block /title text

	DESCRIPTION:
		Requests a progress dialog for an action block.
		REQUEST-PROGRESS is a function value.

	ARGUMENTS:
		steps -- Number of iterations (Type: integer)
		block -- Action block (Type: block)

	REFINEMENTS:
		/title
			text -- Title text (Type: string)

Source code: [request-progress.r](requestors/request-progress.r)

## request-spellcheck

	USAGE:
		REQUEST-SPELLCHECK face /title text /anagram

	DESCRIPTION:
		Requests spellcheck on a widget's text.
		REQUEST-SPELLCHECK is a function value.

	ARGUMENTS:
		face -- (Type: object)

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/anagram -- Anagram option

Source code: [request-spellcheck.r](requestors/request-spellcheck.r)

## request-value

	USAGE:
		REQUEST-VALUE prompt /title text /default value /type datatype /key keytype /chars limit

	DESCRIPTION:
		Requests a value.
		REQUEST-VALUE is a function value.

	ARGUMENTS:
		prompt -- Prompt text (Type: string)

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/default
			value -- Default value (Type: any-type)
		/type
			datatype -- Return type (Type: datatype)
		/key
			keytype -- Key type (Type: datatype)
		/chars
			limit -- (Type: pair)

Source code: [request-value.r](requestors/request-value.r)

## request-verify

	USAGE:
		REQUEST-VERIFY labels values /title text /prompt string /ok

	DESCRIPTION:
		Displays a set of labels/values and prompts for verification.
		REQUEST-VERIFY is a function value.

	ARGUMENTS:
		labels -- Labels (Type: block)
		values -- Values (Type: block)

	REFINEMENTS:
		/title
			text -- Title text (Type: string)
		/prompt
			string -- Prompt text (Type: string)
		/ok

Source code: [request-verify.r](requestors/request-verify.r)

## splash

	USAGE:
		SPLASH spec

	DESCRIPTION:
		Displays a centered splash screen for one or more seconds.
		SPLASH is a function value.

	ARGUMENTS:
		spec -- The face spec or image to display (Type: block file image)

Source code: [splash.r](requestors/splash.r)