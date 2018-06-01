/*:
 # It's a matter of trust!
 ## Hello there! 🤖
 Have you ever asked yourself how an Artificial Intelligence can work?
 It's one of my favourite topics, so you're lucky!
 
 ## Mark has a problem!
 We are in a tricky situation. **Mark** 🙇🏻‍♂️ has to do some researches for his homework to answer some simple Yes/No questions, and he has in front of him a **MacBook** 💻(with internet connection) , a **T-Rex** 🦖 and a **Clairvoyant** 🔮.
 
 Well, where's the problem if he has a MacBook?! He doesn't trust any of them, and because of that he is always answering No!
 
Run the code and tap on Mark to change question!
 
[**Next Page**](@next)
 */
//#-code-completion(everything, hide)


//#-hidden-code

import UIKit
import PlaygroundSupport

//Sets up the values for the scene
Values.shared.questionTime = true
Values.shared.arc1 = 0
Values.shared.arc2 = 0
Values.shared.arc3 = 0

let myViewController = MainViewController()


PlaygroundSupport.PlaygroundPage.current.liveView = myViewController

//#-end-hidden-code



