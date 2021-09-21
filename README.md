
`SwiftUI` `MVVM` `iOS 15.0 RC` `Xcode 13.0 (13A233)`  

`Staus` Solution not found  
`Date` 20 september 2021

I have come across some challenges with SwiftUI I can not get past.
I am struggling with nested ForEach two-way bindings

1. `Error` Index out of range
2. `?` Loses current position when a change is made

---


<img align="left" src="https://user-images.githubusercontent.com/31440186/133977167-e8e9c9ba-a682-472d-aeb8-5c05853a4eaa.MP4" width="222" >

# 1 `Error` Index out of range  

This error occurs in the second level as I choose to call it, that is, when an element is added to an array, which in turn is part of a structure that is an element in another array.

Structural description, <em>hope this is understandable, yes ...</em>
```Swift
ForEach($parentData.children){$child in 
  ForEach($child.toys){$toy in 
    // Index out out of range -> when a new toy is added to toys
  }
}
```

<div>
  <div width="20px" align="left">
<div>
  <em><b>To reproduce the error, do the following:</b></em><br/>
1. Select a parent<br/>
2. Edit parent<br/>
3. Select a child<br/>
4. Add toy<br/>
5. Enter a name and tap Add button<br/>
  </div>
</div>

<br clear="all"/>
<br/>

---

<br/>

<img  align="left" src="https://user-images.githubusercontent.com/31440186/133996415-db30e7bf-8b06-4fe8-9a84-29ddd12e2f43.MP4" width="222" >
  
# 2 `?` Loses current position when a change is made

The expected result when editing the toy, is that by pressing the done button you are brought to the presentation of the toy.

The current result is that you are brought all the way back to the parent. This has something to do with the fact that the list of published parents has been changed, so a redraw is called. It is able to show the correct parent, but it is not able to show the correct child / toy that was the reason for the redraw. Is this a SwiftUI feature or is it me implementing it wrong - that's what I'm wondering

<p style="color:blue;">To reproduce the situation, do the following:</p>
<div>
  <div width="20px" align="left">
<div>
1. Select a parent<br/>
2. Select a child<br/>
3. Select a toy<br/>
4. Tap Edit button<br/>
5. Change toy name<br/>
6. Tap Done button
  </div>
</div>

  <br/>
  <br/>
  <br/>
<em>This example has grown a little bigger than necessary as I have tried to solve the challenge in countless ways. The error with Index out of range starts where you want to edit a parent element.</em>
