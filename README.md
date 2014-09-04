# SuperRecursiveOpenStruct

`SuperRecursiveOpenStruct` is similar to `RecursiveOpenStruct` but with these two differences:

- it supports arrays (either at the top level or nested within a hash)
- it raises `NoMethodError` instead of returning `nil` when accessing an undefined hash key (can be disabled by passing `raise_on_missing_methods: false` to `#initialize`)

## Usage

```ruby
require "super_recursive_open_struct"

sros = SuperRecursiveOpenStruct.new(a: {b: 1})
sros.a.b #=> 1
sros.z #=> NoMethodError: undefined method `z' for #<SuperRecursiveOpenStruct:0x489e1e0 a={:b=>1}>

sros_with_array = SuperRecursiveOpenStruct.new(a: [1, 2, 3])
sros_with_array.a #=> [1, 2, 3]
sros_with_array.a.last #=> 3

SuperRecursiveOpenStruct.new({a: 1}, raise_on_missing_methods: false).z #=> nil
```

## License

MIT

