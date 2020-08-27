+++
title = "Shell with All Maven Classes"
+++

```
alias mvn-shell='jshell --class-path $(find ~/.m2/repository/ -name "*.jar" | tr "\n" ":")'
```

This alias loads all classes in the Maven (m2) repository and make them
available to the shell.
