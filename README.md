# TetraUIKit

If you love the elegant syntax of `SwiftUI`, but stuck with `UIKit` because of legacy code, you have come to the right place. `TetraUIKit` aims to make the existing `UIKit` API looks more like `SwiftUI`.<br/>
`TetraUIKit` also provides extensions to add constraints to views and layout guides in a declarative and more readable syntax instead of the imperative approach. <br/>
With this library, you can now say goodbye to storyboard as it simplifies the effort to create UI programmatically.
 
 ### Attribute setter chaining
 View creation in `TetraUIKit` are built using builder pattern. Here is a sample usage of it:
 ``` Swift
 TetraUITextField(placeholder: "Hello") // UITextField yields the same result here
    .borderStyle(.roundedRect)
    .keyboardType(.numbersAndPunctuation)
    .assign(to: &yourProperty) // You assign this view to a property here
    .target(self, action: #selector(textChanged(sender:)), for: .editingChanged)
    .rightView(UILabel("World"), mode: .always)
    .autocorrectionType(.no)
 ```
 
 `TetraUIKit` also support `Combine`:
 ``` Swfit
 TetraUILabel()
    .text(Just<String>("Hello World!").eraseToAnyPublisher(), 
          cancelledWith: &cancellables)
 ```
 
### Subviews with `UIViewBuilder`
Similar to `ViewBuilder` of `SwiftUI`, `UIViewBuilder` allows creating list of view using `@resultBuilder` pattern. 
``` Swift
UIStackView(axis: .vertical, spacing: 10) {
    UILabel("TetraUIKit")
        .textColor(.systemBlue)
    UILabel("is")
    if youLikeIt {
        UILabel("great")
    } else {
        UILabel("improvable")
    }
}
.backgroundColor(.gray)
```

Note that the views within the builder block will be tagged with their order.

### Adding layout constraints
`TetraUIKit` provide suite of methods to help creating constraints for your views and layout guides. These methods are written in declarative syntax and can be chained as well.

``` Swift
aView
    .edgesPinnedToEdges(of: itsParent, excluding: [.leading])
    .constraintType(.leading,
                    constraintedTo: .trailing,
                    of: itsSibling)
    .dimension(.width, matchedTo: .width, of: itsSibling)
```
 
### Self-layoutable Views
`TetraUIKit` introduces the concept of self-layoutable views. When a view conforms to this protocol, it can use this method to add constraints in a builder pattern manner: `func selfLayout(_ layoutProcess: @escaping (UIView, UIView?, [UIView]?) -> Void) -> Self` <br/>
Within the block of this method, the arguments following their order are the view itself, its parent, and its siblings. You can use these argument to do the layouting. <br/>
``` Swift
UIStackView(axis: .horizontal) {
    TetraUILabel()
        .text(Just<String>("Hello World!").eraseToAnyPublisher(), 
              cancelledWith: &cancellables)
        .backgroundColor(.white)
        .cornerRadius(4)
        .shadow(color: .black, offset: .zero, radius: 2, opacity: 0.2)
        .textAlignment(.center)
    TetraUILabel()
        .text("Hello again!")
        .backgroundColor(.white)
        .cornerRadius(4)
        .shadow(color: .black, offset: .zero, radius: 2, opacity: 0.2)
        .selfLayout { thisView, parent, siblings in // Self-layouting happens here
            guard let previousLabel = siblings?.viewWithTag(0) else {
                return
            }
            
            thisView.dimension(.width, matchedTo: .width, of: previousLabel)
        }
        .textAlignment(.center)
}
```
`TetraUIKit` already implemented some basic view types to conform this for you. They are views that have the prefix of `TetraUI`, e.g. `TetraUILabel` or `TetraUIButton`.<br/>
Keep in mind that the self-layouting only works in a view builder block like the example above. If you create the view and add it to other view manually, this will not work. In that case, you simply add constraints using the provided methods normally.

### Misc
There are a few more little things that `TetraUIKit` adds to your toolbox, please raise an issue if you have any problem using this library.
