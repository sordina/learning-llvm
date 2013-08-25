// The Fibonacci Sequence in all its glory~
//
function fibs() { return [1, cons(1, zipWith(add, fibs, tail( fibs )))] }

exports.main = function() { runList(fibs, 13) }

// Helpers
//
function cons(h,t)        { return function() { return [h,t] }}
function head(list)       { return list()[0] }
function add(x,y)         { return x + y }
function tail(list)       { return function() { return list()[1]() }}

function zipWith(f, x, y) { return function() {
                            return [ f(head(x), head(y)),
                                     zipWith(f, tail(x), tail(y))] } }

function runList(list, n) { while(n-- > 0) {
                            console.log(head(list)); list = tail(list)}}
