------------------------
Lab 2: Whack-A-Mole
CMPE 012 Winter 2019
Mok, Kevin
kemok
-------------------------
What were the learning objectives of this lab?
The learning objective of this lab was to use the ideas given to us in class specifically in the sequential logic and combinational logic presentation in order to build the whack a mole game using mml logic. We also to get us used to using d latches, build full adders, make registers using d-latches and improving our implemenatation of truth tables using logic gates to create 2's complement.

What was your design approach?
First I created the whack check and score adjustment by creating a logic gate where if mole and whack true, add the value would be 1 or if whack and not mole then value would be -1. Afterwards i created two half adders since the first and last adder -- logic gates going to score0 and score1 -- did not need to implement carry's as inputs and two full adders for score 1 and score 2 since the carry's needed to be added as inputs in order to add the binary correctly. I then created the d latch flip flop as a register to store the values so the value would not disappear. Lastly i created the 2's complement truth table to create something for magnitude and found the signed value by testing other sgn coming to the conclusion it was sgn3. For magnitude had to create logic gates so logic would input score correctly with sign and same number as binary representation in register.

Did you encounter any issues? Were there parts of this lab you found enjoyable?
The first issue I encountered was why my game was not initializing, and I could not solve the issue until one of the TA's suggested me to change whack and reset to not. Also creating two's complement for the lab as I was trying to cut the truth table short and find shortcuts for my logic gates to make it look nicer, but i had the problem where -4 and -5 wouold not show up and it was driving me crazy. I ended up just doing the logic fully and not shortchange and reg# in the logic and it worked. The thing I found most enjoyable was testing and playing the game after you completed the lab as it was fun to go back to my childhood and play whack-a-mole and makes me feel better that I was able to create whack-a-mole and play it. Though it was challenging, it was very rewarding to play a childhood favorite after you have recreated and built it.

How would you redesign this lab assignment to make it better?
This lab was actually organized pretty well. The instructions were clear and the TA's were a big help. You gave us the proper amount of time to do this and it was fair to give us 2 weeks to complete the lab with extra credit. Also we were given enough information to finsih the lab. So no changes are needed that I could see.