## Structure and Interpretation of Computer Programs

Here are solutions to exercises from the landmark text [Structure and
Interpretation of Computer Programs](https://mitpress.mit.edu/sicp/),
written by [Gerald Jay
Sussman](https://en.wikipedia.org/wiki/Gerald_Jay_Sussman) and [Harold
Abelson](https://en.wikipedia.org/wiki/Hal_Abelson)

## Emacs setup

### After installing scheme

```
ln -s mit-scheme scheme # so that emacs can find it
```

### In emacs

Add scheme to path

```
(setq exec-path (append '("/Users/edward/Downloads/mit-scheme-12.1/src/mit-scheme.app/Contents/Resources") exec-path))
```

Start scheme REPL

```
M-x run-scheme
```

Connect buffer to REPL

```
M-x scheme-mode
```

## Text

I am indebted to
these legends for crafting such a fine text along with a set of
unforgettable [video
lectures.](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/video-lectures/)

Back when I was a freshman in college, my initial attempt through was
unsuccessful. The concepts in the book seemed overly abstract and the
exercises incredibly difficult. For these reasons I put the book down
and moved onto other things.

The book did, however, leave a lasting impression on me. The few
concepts I did grasp (e.g. applicative-order vs. normal-order
evaluation) seemed to help me a disporportionate amount in my later
years of undergrad, leading me to think "I learned that in the first
chapter of SICP!" on more than one occastion.

I always thought if I could get back to the book it would unlock many
more of its secrets. Since then always had a certain reverence of the
book that's bordered on worship at times.

With an undergraduate education in Computer Science under my belt I
started going through this tome once more and have found that I am
finally able to grasp the material. What's more is it's actually been fun!

For Scheme development, I'm using
[mit-scheme](http://www.nongnu.org/geiser/) with
[emacs](http://www.gnu.org/software/emacs/). I'm also using the
amazing [ParEdit mode](http://www.emacswiki.org/emacs/ParEdit). It
makes editing Lisp code delightful.
