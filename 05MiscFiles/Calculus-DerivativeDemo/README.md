## PowerShell - Calculus Derivative Demonstration

This is a PowerShell demonstration of using the definition of a derivative (shown below from Wikipedia) to evaluate the derivative of y = 2x<sup>4</sup> - 5x<sup>2</sup> + 3 at x = 3. 

![Derivative Definition](https://github.com/jbrusoe/PowerShell/blob/master/05MiscFiles/Calculus-DerivativeDemo/DerivativeDefinition.JPG?raw=true)

The correct answer for this is y' = 8x<sup>3</sup> - 10x = 8(3)<sup>3</sup> - 10(3) = 186. This file allows h (referred to as $deltax in this file) to start at a relatively large number (0.1) and calculates the value as it get closer and closer to 0 (with a final value of 0.00001.

Program Output:
![Program Output](https://raw.githubusercontent.com/jbrusoe/PowerShell/master/05MiscFiles/Calculus-DerivativeDemo/DerivativeDemo-Output.JPG)
