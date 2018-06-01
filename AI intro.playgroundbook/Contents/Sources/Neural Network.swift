import UIKit

///A simple neural network. Nothing too complicated, its purpose is to illustrate the fundamental reasoning behind more comples AIs.
public class NeuralNetwork {
    public init(){
        
    }
    //Setting up weights of the three arcs, they are initialized with values that can go from -1 to 1.
    public var weights = [Float.random(lower: -1, 1),
                          Float.random(lower: -1, 1),
                          Float.random(lower: -1, 1)]
    
    //The outputs of the sigmoid are bound between 0 and 1! If x approaches infinity the result will be 1 at maximum,  negative infinity will go to 0, and the middle point, 0 will return 0.5!
    ///Sigmoid: S shaped function that we use to normalize the weighted sum of the inputs.
    public func sigmoid(_ x: Float) -> Float{
        return 1 / (1 + exp(-x))
    }
    /**The Derivative tells us the level of confidence of the network at a given cycle of training.
     
     If you're enough confident with maths, you may notice that this is not the derivative formula, the true derivative has sigmoid(x) instead of x, but the output is already a sigmoid, so plugging the output in gives the right result :)
     
        How? the more the output is near to 0 or 1, the more the derivative will be close to zero!
     It means that the more you train the Network, the lower the adjustments get.
 **/
    public func sigmoidDerivative(_ x: Float) -> Float{ 
        return x * (1 - x)
    }
    
    ///Calculates the weighted sum, that plugged into the sigmoid becomes the network's prediction.
    public func think(inputs: [Float]) -> Float{
        var weightedSum: Float = 0
        for i in 0..<inputs.count{
            weightedSum += inputs[i] * weights[i]
        }
        return sigmoid(weightedSum)
    }
    
    
    public func train(trainingInputs: [[Float]], trainingOutputs: [Float], numberOfCycles: Int) -> [Float] {
        
        //This is just a playgroundbook limit, so that the training does not take too long. You can remove it!
        let iterations = (numberOfCycles > 200000) ? 200000 : numberOfCycles
        
        for iteration in 1...iterations{
            
            //Calculating result through the sigmoid
            //The % (module) operator gives the remainder of a division, so used with an index over the element count of an array, it allows to go through it as it was circular, starting from the beginning as soon as you go beyond the end.
            let output = self.think(inputs: trainingInputs[iteration % trainingInputs.count])
            
            //Error calculation = training model output - network prediction
            let error = trainingOutputs[iteration % trainingOutputs.count] - output
            
            var adjustments = [Float]()
            //Now we are creating an array that can be added to the weight one to give minor adjustments at each cycle (Notice that if the input was 0 there will be no adjustment because it was not relevant on the results). How cool is that?
            for input in trainingInputs[iteration % trainingInputs.count]{
                adjustments.append(sigmoidDerivative(output) * error * input )
            }
            //Adding adjustments to the weights
            for i in 0..<adjustments.count{
                weights[i] += adjustments[i]
            }
            
            
        }
        
        return self.weights
        
    }
}


/// MARK: Example
/*let neuralNetwork = NeuralNetwork()

print ("Random starting synaptic weights: ")
print (neuralNetwork.weights)

//Training set! with inputs and outputs
 //If you notice, the output should be true only when the 2nd input is true!
let trainingInputs: [[Float]] = [[0, 0, 1],
                                       [1, 1, 1],
                                       [0, 1, 1],
                                       [1, 0, 1]]
let trainingOutputs: [Float] = [0, 1, 1, 0]


neuralNetwork.train(trainingInputs: trainingInputs,trainingOutputs: trainingOutputs, numberOfIterations: 1000)

print ("New synaptic weights after training: ")
print (neuralNetwork.weights)

//Test with a new case
print ("Considering new situation [1, 0, 0] -> ?: ")
print (neuralNetwork.think(inputs: [1, 0, 0]))

print ("Considering new situation [0, 1, 0] -> ?: ")
print (neuralNetwork.think(inputs: [0, 1, 0]))
*/
