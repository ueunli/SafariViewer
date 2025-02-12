# SafariViewer
SFSafariViewController bug report

---
## Two Issues with Screen Rotation in SFSafariViewController
When creating the sample project, I tested it on an iOS 18.0 device using Xcode 16.1(16B40), but the issue also appears to occur on iOS 16.2 and other versions.
On iPadOS, the bottom bar area behaves differently, so I couldn’t confirm whether the same issue occurs. (Tested on the iPadOS 18.0 simulator.)

### [Reproduction Steps]
> You can try either of these steps.
1. Present in portrait mode → Rotate to landscape → Rotate back to portrait
1. Present in landscape mode → Rotate to portrait

### [Issues]
> You can observe the first issue by uncommenting case [B] and the second issue by uncommenting case [C].
1. The topAnchor is positioned above the status bar’s topAnchor.
1. The specified `preferredBarTintColor` and `preferredControlTintColor` are invalidated.

I accidentally discovered a workaround that might be the key to understanding the root cause, so I created a sample project.
In the code, I listed three cases to explain my discovery process, but there are only two actual issues.
- The cause of the first issue is unknown.
-	The second issue seems to be related to `viewWillTransition(to:with:)`.

In the sample project, I added comments saying “Breakpoint here” before and after calling `super.viewWillTransition(to: size, with: coordinator)`. This is because, in Xcode’s Debug Area (variables section), I noticed that some internal elements’ colors changed to system colors after calling `super.viewWillTransition(to: size, with: coordinator)`. However, I observed this only once, didn’t take a screenshot, and haven’t been able to reproduce it since, so I’m not entirely sure.
