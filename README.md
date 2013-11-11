oREST
=====

oREST ("o" for greek "omicron" or "objective") is a small and simple Objective-C library to send HTTP requests.

Example
------------

``` objective-c
id orest = [[oREST alloc] init];
[orest GET:@"http://google.com/"];
NSLog(@"%@", [orest requestResult]);
```

Sidenote
------------
This is an Objective-C port of my [μREST](http://github.com/bbrodriges/urest/) python module.