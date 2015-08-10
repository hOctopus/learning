function PrimeFactorizer()
{
  var factorTime = 0;
  var num = prompt("Would you like to see the largest prime factor of an number???\n\nIf so, enter that number!!! I will reveal the information!!\n\nAlso, I will round the number into an integer, in case you enter a decimal like a weirdo.\n");
  var numOrig = num;
  if(isNaN(num))
  {
    window.alert("That's not a number, silly!!!!")
  }
  else if(num>1000000000)
  {
    window.alert("Woah! That number is HUGE!!!\n\nKeep it under a billion (American) please, for the sake of your browser.")
  }
  else if(num!=null)
  {
    factorTime = Date.now();
    num = Math.round(num);
    var factorArray=[];
    function LargestPrimeFactor(num)
    {
      var largeFactor = 0;
      for(var factor = 2; factor <= Math.floor(num/2); factor++)
      {
        var isPrime=true;
        // declare a boolean we can use to check if the factor is prime
        // it gets reset to its default every time the loop checks factor against num
        if(num%factor===0) // 'factor' is a factor of num
        {
        // check now if factor can be divided by any prime
          for(var prime = 2; prime <= Math.floor(factor/2); prime++)
          {
          //if 'factor' is not divisible by any number except itself, then it is prime
            if((factor%prime===0) && (factor!=prime))
          //checks if prime is a factor of 'factor', if so then factor is not prime
            {
              isPrime=false;
            }
          }
          //if factor is prime, check if it is larger than the last largest prime factor
          //if so, store it
          if(isPrime)
          {
            var notInArray=true;
            while(notInArray)
            {
              for(var i = 0; i < factorArray.length; i++)
              {
                if(factorArray[i]===factor)
                {
                  notInArray=false;
                }
              }
              if(notInArray)
              {

                  factorArray.push(factor);

                notinArray=false;
              }
            }
            if(factor>largeFactor)
            {
              largeFactor = factor;
            }
          }
        }
      }
      return largeFactor;
    }
    if(LargestPrimeFactor(num) > 0)
    {
      var lpf = LargestPrimeFactor(num);
      factorTime = Date.now()-factorTime;
      var decimalYes = " ";
      if(numOrig!=num)
      {
        decimalYes = " (rounding to " + num.toString() + ") ";
      }
      factorArray.pop();
      window.alert("The largest prime factor of " + numOrig + decimalYes + "is " + lpf +"!!\n\nIn case you wondered, the other factor(s) are " + factorArray.join(", ") + ".\n\n(It took me " + (factorTime/1000).toFixed(3) + " seconds (" + factorTime.toFixed(1) + " ms) to figure all that out!)\n");
    }
    else
    {
      window.alert("Woah! Guess what! " + num + " is a prime number!!!\n");
    }
  }
  window.alert("Click the button over there again to do it again!!\n");
}
