TransactionAlert
===========

Animated Alert written in SwiftUI.

<img src="https://raw.githubusercontent.com/huseyinbagana/TransactionAlert/master/question.PNG" width="25%"> </img><img src="https://raw.githubusercontent.com/huseyinbagana/TransactionAlert/master/loading.gif" width="25%"></img> <img src="https://raw.githubusercontent.com/huseyinbagana/TransactionAlert/master/success.gif" width="25%"></img>


Easy to use
----

### Get Started

1. Add a **TAViewModel** instance as an *environment object* to your Root View in you *SceneDelegate*
```Swift
// 1.1 Create the model and set environmentObject
let contentView = ContentView().environmentObject(TAViewModel())
    
//Common SwiftUI code to add the rootView in your rootViewController
if let windowScene = scene as? UIWindowScene {
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UIHostingController(
        rootView: contentView
    )
    self.window = window
    window.makeKeyAndVisible()
}
```
2. Add the **Transaction Alert** to your *Root View*

```Swift
struct ContentView: View {

    var body: some View {
       ...
       .transactionAlert()
    }
}
```
3. In your views add a reference to the *environment object* and than just call the `.set(state:)` func whenever you want like this:

```Swift
@EnvironmentObject var taViewModel: TAViewModel

...

Button(action: {
    taViewModel.set(.error(style:--customstyle--))
}, label: {
    Text("Show Transaction Alert")
})
```
3. For hide alert just call the `.hide()` func whenever you want like this:

```Swift
...

Button(action: {
    taViewModel.hide()
}, label: {
    Text("Hide Transaction Alert")
})
```
### Alert States
```Swift
...

taViewModel.set(.start(...)) // Question
taViewModel.set(.loading(...)) // Loading
taViewModel.set(.error(...)) // Error
taViewModel.set(.success(...)) // Success
taViewModel.set(.custom(...)) // Also you can set custom view with style

```
