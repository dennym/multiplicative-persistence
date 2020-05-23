# Multiplicative Persistence

## Ruby Approach

```
  gem install ffi
  ruby ruby/start.rb
```


gcc -shared -o ../build/libpow.so -fPIC pow.c

## TODO:

* utilize parallels to move power calculation to processes let @current_number only return the potencies
* OR use https://github.com/rtomayko/posix-spawn#posixspawn-as-a-mixin and move the potency calculation and the number check to separate file