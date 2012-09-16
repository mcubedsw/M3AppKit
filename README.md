M3AppKit 1.0a1
==========

M3AppKit is a collection of categories and classes that extend and enhance the AppKit framework. This functionality is taken from various M Cubed applications

M3AppKit is licensed under the MIT licence

**Please consider this a 1.0 alpha of the framework.** While the method signatures are unlikely to change, I am not yet ready to mark this as final, so source compatibility isn't guaranteed between source checkins (ie methods may be added/removed/changed without any sort of deprecation warning). I will hopefully have a version I'm ready to declare 1.0 final in the near future.

M3AppKit includes:
- Controllers for managing beta versions and installing from disk images
- Alerts with block based callbacks
- A table/outline view column visibility controller
- View controller-based preferences window
- A navigation view (see the Lighthouse Keeper sidebar for an example)
- Constraint-based split view
- Simplified constraint production
- Convert NSColors to and from hexadecimal strings.
- Subview ordering (including a block based subview sort)

And more

M3AppKit requires Xcode 4.4+ and runs on Lion or later (requires the 10.8 SDK to compile)