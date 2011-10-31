# MassiveGit

MassiveGit - revision controlled database which implements Git Object Model.

## Implementation

MassiveGit currently implemented on top of riak [http://basho.com/products/riak-overview/].
In future other backends may be implemented.


Currently MassiveGit depends on custom version of riak-js module [https://github.com/podviaznikov/riak-js].
Install it from this repository.

## Tips

Remove riak data from this directory:

`/var/lib/riak/bitcask`


## Configurations

Please updated {js_thread_stack, 32} on your app.config.

See [http://wiki.basho.com/MapReduce.html] for details how to do this and why.

## License

(The MIT License)

Copyright (c) 2011 CircuitHub., http://circuithub.com/

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

