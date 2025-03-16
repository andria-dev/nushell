use std *

#[test]
def first_ [] {
    assert streaming "first" { first } 1
    assert streaming "first" { first 3 } 3
}

#[test]
def get_ [] {
    assert streaming "get > index" { get 0 } 1
    assert streaming "get > index" { get 2 } 3
    assert streaming "get > column" { get name | first } 1 --generator {|id| { out: { id: $id }, next: ($id + 1) }}
    assert streaming "get > column" { get name | first 3 } 3 --generator {|id| { out: { id: $id }, next: ($id + 1) }}
}

#[test]
def drop_ [] {
    assert streaming "drop" { drop | first } 2
    assert streaming "drop" { drop 3 | first } 4
}

#[test]
def find_index [] {
    assert streaming "std iter find-index" { iter find-index {|x| $x == 0} } 1
    assert streaming "std iter find-index" { iter find-index {|x| $x == 2} } 3
}

#[test]
def intersperse [] {
    assert streaming "std iter intersperse" { iter intersperse 99 | first } 1
    assert streaming "std iter intersperse" { iter intersperse 99 | first 3 } 2
}

#[test]
def select_ [] {
    assert streaming "select > index" { select 0 } 1
    assert streaming "select > index" { select 2 } 3
    assert streaming "select > column" { select name | first } 1 --generator {|record| { out: $record, next: { name: ($record.name + "A"), age: 0 } }} --generator-initial-value { name: "" }
    assert streaming "select > column" { select name | first 3 } 3 --generator {|record| { out: $record, next: { name: ($record.name + "A"), age: 0 } }} --generator-initial-value { name: "" }
}

#[test]
def where_ [] {
    assert streaming "where" { where id >= 2 | first } 3 --generator {|id| { out: { id: $id }, next: ($id + 1) }}
    assert streaming "where" { where id >= 2 | first 3 } 5 --generator {|id| { out: { id: $id }, next: ($id + 1) }}
}

#[test]
def each_ [] {
    assert streaming "each" { each {|x| $x + 1} | first } 1
    assert streaming "each" { each {|x| $x + 1} | first 3 } 3
}

#[test]
def any_ [] {
    assert streaming "any" { any {|x| $x == 0} } 1
    assert streaming "any" { any {|x| $x == 2} } 3
}

#[test]
def append_ [] {
    assert streaming "append" { append 11 | first } 1
    assert streaming "append" { append 11 | first 3 } 3
}

#[test]
def chunks_ [] {
    assert streaming "chunks" { chunks 1 | first } 1
    assert streaming "chunks" { chunks 3 | first } 3
    assert streaming "chunks" { chunks 3 | first 2 } 6
}

#[test]
def each_while [] {
    assert streaming "each while" { each while {|x| if $x < 5 { $x * 2 }} | first } 1
    assert streaming "each while" { each while {|x| if $x < 5 { $x * 2 }} | first 3 } 3
}

#[test]
def enumerate_ [] {
    assert streaming "enumerate" { enumerate | first } 1
    assert streaming "enumerate" { enumerate | first 3 } 3
}

#[test]
def filter_ [] {
    assert streaming "filter" { filter {|x| $x >= 2} | first } 3
    assert streaming "filter" { filter {|x| $x >= 2} | first 3 } 5
}

#[test]
def find_ [] {
    assert streaming "find" { find 2 } 3
}
