# Cookbook

## Using SQLite with widgets

### Flat versus blocked data

RebGUI widgets that accept a block of values expect the block to be 'flat', that is, all values in a single block. This contrasts with the way in which database data is often represented, that is, a block of blocks with each block containing row values.

	>> describe "names"          ; two column table
	== ["Name" string! "Age" integer!]

	>> SQL "select * from names" ; 'blocked' data
	== [["Bob" 19] ["Pete" 26] ["Jane" 23]]

	>> SQL "select * from names" ; 'flat' data
	== ["Bob" 19 "Pete" 26 "Jane" 23]

You can still use a database/driver that returns blocked data, just be aware that you must flatten the block prior to passing it to a RebGUI widget.

> SQLite Driver. The remainder of this section assumes you are using the [SQLite Driver](../sqlite.html). The sample database used in this example can be created with the following script:

	Rebol []

	do %sqlite.r

	CONNECT/create %my_db.db

	SQL "create table names (name,age)"

	foreach [name age] ["Bob" 19 "Pete" 26 "Jane" 23] [
		SQL reduce ["insert into names values (?,?)" name age]
	]

	DISCONNECT

### Establishing a SQLite connection

First we must include both the RebGUI and SQLite libraries, then connect to our database with the `/flat` refinement:

	Rebol []

	do %rebgui.r
	do %sqlite.r

	CONNECT/flat %my_db.db

	display ...

	do-events

### Composing query data into a widget

Using `compose/only` is a handy way of assigning the block returned from a query as the widget's `data` block, as in:

	display "Test" compose/only [
		text-list data (SQL "select name from names")
		drop-list data (SQL "select age from names")
	]

Composing data into a `table` widget requires that you match the column specifications with the return set, as in:

	display "Test" compose/only [
		table options ["Name" left .7 "Age" right .3] data (sql "select * from names")
	]

### Dynamically updating a widget with query data

Performing similar operations at runtime is then as simple as:

	display "Test" [
		t: text-list
		button "Append" [
			insert t/data SQL "select name from names"
			t/redraw
		]
		button "Replace" [
			insert clear t/data SQL "select name from names"
			t/redraw
		]
	]

Note that the only difference between appending and replacing data is the use of `clear`.

## Creating a RebGUI application using the SDK

### Include files

Your script needs to include the following files (change paths to suit):

	Rebol [
		Encap: [title ""]
	]

	#include %/c/Rebol/Rebol-sdk/source/gfx-colors.r
	#include %/c/Rebol/Rebol-sdk/source/gfx-funcs.r
	#include %rebgui.r

### Calling enface from another script

You can call `enface` from another script as follows:

	script: request-file/only/filter ["*.r"]

	call reduce [%/c/Rebol/Rebol-sdk/tools/enface.exe script]

### Windows Icons & Version information

#### ResHacker

On Windows an indispensable tool for changing an executable's resources is [Resource Hacker](http://www.angusj.com/resourcehacker), which can be called from a script to replace icons and/or version information as follows:

	call "ResHacker.exe -addoverwrite app.exe,app.exe,app.ico,ICONGROUP,Rebol,1033"

	call "ResHacker.exe -addoverwrite app.exe,app.exe,app.res,VERSIONINFO,1,1033"

To see your icon change(s) you may have to highlight your executable (in /Explorer/) and select **View|Refresh** from the menu.

#### .ico file

The [.ico](https://en.wikipedia.org/wiki/ICO_%28file_format%29) file must be a multiple icon file containing 9 icons as follows:

1. 48 x 48 (16 colors)
2. 32 x 32 (16 colors)
3. 16 x 16 (16 colors)
4. 48 x 48 (256 colors)
5. 32 x 32 (256 colors)
6. 16 x 16 (256 colors)
7. 48 x 48 (16.8mil colors)
8. 32 x 32 (16.8mil colors)
9. 16 x 16 (16.8mil colors)

#### .res file

The `.res` file is created by using /Resource Hacker/ to open (**File|Open**) your newly created executable and:

1. Navigating to **Version Info|1|1033**
2. Changing text details as appropriate
3. Clicking **Compile Script**
4. Clicking **Action|Save Resource as a .res file**

> The most common cause of problems are incompatible `.ico` and/or `.res` files. The `.ico` file should be around 24.6 KB in size, the `.res` file about 712 bytes.

### Mac OS/X application bundles

#### Bundle directory layout

Creating an application bundle on Mac is easy, just follow these steps:

1. Create a directory named #MyApp.app#
2. Ctrl-click the directory and select *Show Package Contents*
3. Now create the following file layout:

	MyApp.app
		Contents
			Info.plist
			MacOS
				MyApp
			Resources
				Icon.icns

#### Info.plist

`Info.plist` is an XML file of key/string pairs similar to the following:

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
	<dict>
		<key>CFBundleExecutable</key>
		<string>MyApp</string>
		<key>CFBundleIconFile</key>
		<string>Icon.icns</string>
		<key>CFBundleIdentifier</key>
		<string>com.mydomain.MyApp</string>
		<key>CFBundlePackageType</key>
		<string>APPL</string>
		<key>CFBundleShortVersionString</key>
		<string>1.0.0</string>
	</dict>
	</plist>

Full documentation on all plist keys can be found at http://developer.apple.com/documentation/MacOSX/Conceptual/BPRuntimeConfig/Articles/PListKeys.htmldeveloper.apple.com.

#### .icns file

A [.icns](http://en.wikipedia.org/wiki/Apple_Icon_Image) file is similar to a Windows .ico file, but typically only needs the following four file formats:

1. 128 x 128 (16.8mil colors)
2. 48 x 48 (16.8mil colors)
3. 32 x 32 (16.8mil colors)
4. 16 x 16 (16.8mil colors)

A great utility for creating #.icns# files is [FastIcns](http://www.apple.com/downloads/macosx/icons_screensavers/fasticns.html).

#### Working directory

You may want to package your application to support the following structure:

	MyApp.zip
		Logo.png	; Shared logo
		MyApp		; Linux binary
		MyApp.app/	; Mac OS/X bundle
		MyApp.exe	; Windows executable
		MyApp.ini	; Shared ini settings
		Resources/	; Shared resources

in which case it is desirable to have your encapped Mac OS/X script set its working directory to the same directory where the app bundle resides. This can be done with the following line of code at the start of your script:

	all [2 = fourth system/version change-dir join first split-path system/options/boot %../../..]

> This allows you to ship one zip file that works on multiple platforms. Now *that's* what I call a universal binary!

## Creating an image of a display

The following code illustrates how to create a function key handler that grabs the current RebGUI display and saves it as an image. First we need to create a handler:

	do %rebgui.r

	ctx-rebgui/on-fkey/f3: make function! [face event] [
		save/png %screen.png to image! face
		browse %screen.png ; or call %screen.png
	]

then a display to grab:

	display "Screen" [
		after 1
		area "Press F3 to screen capture this display."
		bar
		button "Close" [quit]
	]

	do-events

Run this script and press F3 to browse an image of the display. When you have multiple RebGUI displays, click the window bar to make the correct one active before pressing F3.

> This little trick is quite handy for producing the images typically required in a document and / or online guide.