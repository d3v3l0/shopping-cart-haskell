shopping-cart-haskell
=====================

[![CI Status](https://github.com/gvolpe/shopping-cart-haskell/workflows/Haskell%20CI/badge.svg)](https://github.com/gvolpe/shopping-cart-haskell/actions)

Haskell version of the Shopping Cart developed in the book [Practical FP in Scala](https://leanpub.com/pfp-scala).

### How to run

Within a Nix Shell (run `nix-shell` - recommended), follow the commands below.

#### Run web application

```
cabal new-run shopping-cart
```

#### Run tests

```
cabal new-test --test-show-details=streaming
```

### Design walk-through

TODO: Explain how it differs from its Scala counterpart.
