function LargestPrimeFactorizer()
{
  var num = prompt("Would you like to see the largest prime factor of an integer??? If so, enter that number!!!")
  if(isNaN(num))
  {
    window.alert("That's not a number, silly!!!!")
  }
  else
  {
    function LargestPrimeFactor(num)
    {
      var largeFactor=0;
    // check what whole numbers num can be divided by, up to its highest divisor
    // in the test of 1000, the lowest possible factor is 2 and the highest is 500
    // the lowest check will always be 2, because 2 is the first prime
    // the highest check will always be half of the input, half being the highest possible divisor
    // correct output for an input of 1000: 5
    // correct output for 1347: 449
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
            if(factor>largeFactor)
            {
              largeFactor = factor;
            }
          }
        }
      }
      return largeFactor;
    }
    window.alert("The largest prime factor is " + LargestPrimeFactor(num) +"!!");
  }
  window.alert("Click the button again to do it again!!");
}
