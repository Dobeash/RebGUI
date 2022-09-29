# RebGUI

RebGUI is a lightweight alternative to VID that was designed and built from the ground-up on top of Rebol/View. It provides a rich, consistent set of OS-like widgets for building applications.

**This software requires REBOL/View 1.3, which can be found at http://www.rebol.com.**

# What's wrong with VID?

Nothing. VID provides an easy to use, high-level interface dialect to most of View's capabilities. You can quickly create a GUI in as little as one line of code:

	view layout [text "Hello World!"]

without having to worry about how it works under the covers. VID does a lot on your behalf without you even realizing it. And there's the rub; when you do know exactly what you want and how best to achieve it you often have to figure out what VID is and isn't doing and then work around it.

VID provides a great free-form generalized approach to building GUIs, what it isn't so good at is building minimalist, high-performance application interfaces.

# Features

- **Works out of the box** - Just add `do %rebgui.r` to your script and you are ready to go. You can even use it from the Rebol/SDK without having to load `%view.r`!
- **Lean and mean** - RebGUI is fast and uses little memory due to its minimalist design.
- **Self-contained widgets** - RebGUI provides a clean separation between its main display function and the widgets it can use. This allows you to easily extend, trim or modify the default widgets according to the needs of your project.
- **Handles common window management tasks** - Automatic window and gadget resizing, scroll-wheel support and widget origin, spacing and margin settings are all handled by the display function.
- **Reliable** - Given the small code-base and minimalist design, it is easy to "Grok" - there are not huge interdependencies or inheritance rules to understand. If you need to figure out how a widget works, then you look at its code and that's it!

# Design Principles

These principles gain efficiency at the cost of flexibility. If you need a flexible, generic solution then use VID.

- **Minimalist** - Only the most common use cases are catered for.
- **Efficient** - The display function creates optimal face / feel definitions.
- **Fault Intolerant** - Minimal or no error trapping / debug code is used.
- **Off by default** - Where something could reasonably be present or not (e.g. a default color or feel) it will not be present. In VID the philosophy is, *if you don't want it, disable it*; in RebGUI the philosophy is, *if you want it, add it*.
- **Hard-coded defaults** - Defaults are coded into the system with little or no ability to change them at run-time (and without the overhead of a dynamic stylize system).
- **Global name-space pollution** - As few words as possible are added to the global name-space.

# Widgets

- **Minimal set** - Only the most common widgets are provided. Domain specific variations (such as H1, H2, etc) are omitted.
- **Complete** - Widgets, as a rule, contain all the code necessary to define their appearance and behavior. This is in contrast to VID styles where many of their facets (e.g. feels) are generalized and shared.
- **Minimal faces** - Intelligent use of multiple facets of a face at the same time (e.g. text, image and effect) minimize the need for sub-faces.

# Documentation

> Updated 25-Jan-2011

- **USER.md** - describes how to build and use RebGUI displays.
- **WIDGETS.md** - describes the use and operation of the various widgets.
- **REQUESTORS.md** - describes the use and operation of the various requestors.
- **FUNCTIONS.md** - describes the use and operation of the various functions.
- **COOKBOOK.md** - RebGUI tricks, tips & code examples.
- **DESIGNER** - describes how to create RebGUI widgets.

# Rebol Documentation

- [Graphic System Reference](http://www.Rebol.com/docs/view-system.html)
- [DRAW Dialect Reference](http://www.Rebol.com/docs/draw-ref.html)
- [Image Datatype](http://www.Rebol.com/docs/image.html)
