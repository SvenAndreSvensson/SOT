
`SwiftUI` `MVVM` `iOS 15.0 RC` `Xcode 13.0 (13A233)`  

`Staus` Solution not found  
`Date` 20 september 2021

I have come across some challenges with SwiftUI I can not get past.
The example consists of adding parents, who may have children who may have toys.

---

<img align="left" src="https://user-images.githubusercontent.com/31440186/133977167-e8e9c9ba-a682-472d-aeb8-5c05853a4eaa.MP4" width="222" >

# `Error` Index out of range  
the video on the left shows this error, it happens when you add a toy to a child's bound list of toys, the child is bound to its parent's children list. the problem occurs in the second level.

To reproduce the error, do the following:
1. Select a parent
2. Edit parent
3. Select a child
4. Add toy
5. Enter a name and tap Add button


