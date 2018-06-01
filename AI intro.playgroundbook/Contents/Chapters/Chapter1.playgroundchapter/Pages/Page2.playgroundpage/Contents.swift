//#-hidden-code
setArcWeights(left: -1, center: -1, right: -1)
//#-end-hidden-code
/*:
 # Weigh every opinion!
 If you want to see how a computer sees this kind of problem, make it appear by code!
 Try `letMeSee()`!

 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, letMeSee())
//Write under here and run the code!

/*:
 ## What is this?
 This is exactly the same structure as before! We have some inputs [🦖,💻,🔮] and an output [🙇🏻‍♂️] that are called **nodes**, and the connections between them, called **arcs**. The multiplier of an arc is called **weight** and it can increase or decrease the dimension of an input. Those numbers represent Mark's trust!
 
 The inputs (1 for Yes, 0 for No) get multiplied by the arcs' _weights_ and then they are added together: **if the sum is high we get close to 1; if it's low we get closer to 0.**
  This kind of structure is known as _Artificial Neural Network_, and it's used almost anywhere in the AI field!
 
 **Tap on the inputs** to change them, you will see that we can't get a value close to 1.
 _How can we solve this?_
  */
//#-code-completion(identifier, hide, letMeSee())
//#-code-completion(identifier, show, setArcWeights(left:center:right:))
//#-code-completion(description, show, "setArcWeights(left: Float, center: Float, right: Float)")
//Feel free to change the weights!
setArcWeights(left: -1,center: -1,right: -1)
/*:
  [**Next Page**](@next)
 */
//#-hidden-code
import UIKit
import PlaygroundSupport

let myViewController = MainViewController()

PlaygroundSupport.PlaygroundPage.current.liveView = myViewController
//#-end-hidden-code
