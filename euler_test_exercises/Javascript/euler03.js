function LargestPrimeFactorizer()
{
  var start = Date.now();
  var num = prompt("Would you like to see the largest prime factor of an integer??? If so, enter that number!!!")
  if(isNaN(num))
  {
    window.alert("That's not a number, silly!!!!")
  }
  else if(num!=null)
  {
    var factorArray=[];
    function LargestPrimeFactor(num)
    {
      var largeFactor=0;
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
      window.alert("The largest prime factor of " + num + " is " + LargestPrimeFactor(num) +"!!\n The factor(s) are " + factorArray.join(", ") + ".\n (It took me " + ((Date.now()-start)/1000).toFixed(2) + " ms to figure that out!)");
    }
    else
    {
      window.alert("Woah! Guess what! " + num + " is a prime number!!!");
    }
  }
  window.alert("Click the button over there again to do it again!!");
}
