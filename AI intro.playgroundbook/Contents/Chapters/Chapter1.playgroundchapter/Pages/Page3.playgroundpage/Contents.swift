//#-hidden-code

//#-end-hidden-code
/*:
 # Final step: training!
 Computers determine weights comparing their outputs to the expected ones, and then adjusting the weights by a little bit for each cycle: this is called **Training**.
 
 We want Mark to answer Yes (=1) only when the 💻 says Yes! Otherwise we want a No(=0). 
 
First of all we need some **training data** based on this rule.
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, letMeSee())
let myTrainingInputs: [[Float]] =
    //[🦖,💻,🔮]
//#-editable-code array of inputs
    [[0, 0, 1],
     [1, 1, 1],
     [0, 1, 1],
     [1, 0, 1]]
//#-end-editable-code
let myTrainingOutputs: [Float] = //Corresponding outputs
    /*#-editable-code array of outputs*/[0, 1, 1, 0]/*#-end-editable-code*/
/*:
 Now we can train a fully working network! The more training cycles, the better!
 */
public let neuralNetwork = NeuralNetwork()

let newWeights: [Float]
newWeights = neuralNetwork.train(
    trainingInputs: myTrainingInputs,
    trainingOutputs: myTrainingOutputs,
    numberOfCycles: /*#-editable-code number of repetitions*/10000/*#-end-editable-code*/)

setArcWeights(weightsArray: newWeights)

/*#-editable-code letMeSee()*/letMeSee()/*#-end-editable-code*/
/*:
 ### Isn't it amazing?
 Notice that now Mark's answers are exact even with inputs that were not in the training data!
 More complex AIs are just like that, but with hundreds or even thousands of nodes! From pictures to your voice, everything is converted into 0 and 1 values so that the network can learn to give an answer!
 
 Here you can play with everything, and if you want to know how it works, in this PlaygroundBook i put the entire working code, explained **step by step!** 🐻🎶*/
//#-hidden-code
import UIKit
import PlaygroundSupport

let myViewController = MainViewController()

PlaygroundSupport.PlaygroundPage.current.liveView = myViewController
myViewController.viewDidLoad()
//#-end-hidden-code


