# MASTERMIND

**Mastermind** or **Master Mind** is a code-breaking game for two players. The modern game with pegs was invented in 1970 by *Mordecai Meirowitz*, an Israeli postmaster and telecommunications expert. It resembles an earlier pencil and paper game called *Bulls and Cows* that may date back a century or more.

## Gameplay and rules
*  *A decoding board*, with a shield at one end covering a row of four large holes, and twelve (or ten, or eight, or six) additional rows containing four large holes next to a set of four small holes;
*  *code pegs* of four different colors, with round heads, which will be placed in the large holes on the board; and
*  *key pegs*, some colored black, some white, which are flat-headed and smaller than the code pegs; they will be placed in the small holes on the board.

The two players decide in advance how many games they will play, which must be an even number. One player becomes the codemaker, the other the codebreaker. The codemaker chooses a pattern of four code pegs. Duplicates and blanks are allowed depending on player choice, so the player could even choose four code pegs of the same color or four blanks. In the instance that blanks are not elected to be a part of the game, the codebreaker may not use blanks in order to establish the final code. The chosen pattern is placed in the four holes covered by the shield, visible to the codemaker but not to the codebreaker.
<br />
<br />
## `Playing the game`
In the root directory, on your preferred command line interface run:
```
ruby mastermind.rb
```
<br />

### Instructions
When playing the game you will see flags next to the board as you guess the combination:

`Red Flag`: Means you guessed the right colour in the right position.

`White Flag`: Means you guessed the right colour in the wrong position.

These are your hints. The end goal is to guess all four correct colours in the exact order.

For example:

If the secret code is **'bgyw'** and you guessed **'wygb'**. You will get four white flags, meaning you guessed all four colours right but they are all in the wrong order. You must figure out the correct order, and your final guess must be exactly **'bgyw'**.
<br />
<br />
## Acknoledgements

This project is part of [The Odin Project curriculum](https://www.theodinproject.com/courses/ruby-programming/lessons/oop?ref=lnav). Awesome on-line web development learning place!

* [Reference](https://en.wikipedia.org/wiki/Mastermind_(board_game))