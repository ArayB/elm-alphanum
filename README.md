## What is this?

An Elm application that converts a comma separated list of numbers into a list of letters where each letter maps to that position in the alphabet.
E.g. `20,8,5` becomes `the`

You can then add an offset:

With an offset of 1 `19,7,4` becomes `the` as 1 is added to each value before converting.

Negative offsets are supported:

With an offset of -1 `21,9,6` becomes `the` as 1 is subtracted from each value before converting.

(Ok, I don't actually subtract the offset I rotate the array that maps letters to numbers, the effect is the same though)

## Runnnnn

[Install Elm](https://guide.elm-lang.org/install.html)

You can also install Elm with [asdf](https://github.com/asdf-vm/asdf)

With Elm installed run `elm reactor` from project directory
