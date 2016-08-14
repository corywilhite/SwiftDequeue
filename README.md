# SwiftDequeue
Simple utility file for making UITableView/UICollectionView cell registration and dequeueing feel more swifty

## Implementing
Given a cell:

```swift
class NewCell: UITableViewCell {

}
```

Simply tagging the cell with the associated protocols of `Identifiable` and/or `NibProvidable` if the cell uses a nib will allow for the cell to be used with the UITableView/UICollectionView extension methods.

```swift
class NewCell: UITableViewCell, Identifiable, NibProvidable {

}
```

This will allow the following methods to be called on the cell:
```swift
let cellId = NewCell.identifier // String identifier equal to "NewCell"
let nib = NewCell.nib // Looks in the bundle where the NewCell file  is located and tries to load a nib named "NewCell"
```

Given a `UIViewController` with an already initialized `UITableView` instance `tableView`:
```swift
tableView.register(NewCell.self)
```
You can conform to just `Identifiable` or both of `Identifiable` and `NibProvidable` and you can use the same tableView register method for that class.

When trying to dequeue:
```swift
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  // returns a NewCell instance or crashes if the class, nib hasn't been registered yet
  let cell = tableView.dequeue(NewCell.self, at: indexPath) 
  // configure cell here
  return cell
}
```
