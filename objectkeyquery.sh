#!/bin/bash

getValueByKey() {
  local object=$1
  local key=$2

  IFS='/' read -ra key_parts <<< "$key"

  for part in "${key_parts[@]}"; do
    if [[ $part =~ ^[0-9]+$ ]]; then
      # Handle array index
      object=$(echo "$object" | jq -r ".[$part]")
    else
      # Handle object key
      object=$(echo "$object" | jq -r ".$part")
    fi
  done

  echo "$object"
}

# Example
nested_object='{"a":{"b":{"c":"d"}}}'
key="a/b/c"
result=$(getValueByKey "$nested_object" "$key")
echo " $result " # Expected: d


nested_object='{"x":{"y":{"z":"w"}}}'
key="x/y/z"
result=$(getValueByKey "$nested_object" "$key")
echo " $result " # Expected: w


nested_object='{"foo":{"bar":{"baz":42}}}'
key="foo/bar/baz"
result=$(getValueByKey "$nested_object" "$key")
echo " $result " # Expected: 42


nested_object='{"obj":{"prop":{"arr":[1,2,3]}}}'
key="obj/prop/arr"
result=$(getValueByKey "$nested_object" "$key")
echo " $result " # Expected: [1,2,3]


nested_object='{"a":{"b":{"c":{"d":"e"}}}}'
key="a/b/c/d"
result=$(getValueByKey "$nested_object" "$key")
echo " $result " # Expected: e


nested_object='{"a":{"b":{"c":{"d":{"e":{"f":{"g":{"h":{"i":{"j":"k"}}}}}}}}}}'
key="a/b/c/d/e/f/g/h/i/j"
result=$(getValueByKey "$nested_object" "$key")
echo " $result " # Expected: k


nested_object='{"users":[{"id":1,"name":"John"},{"id":2,"name":"Alice"}]}'
key="users/1/name"
result=$(getValueByKey "$nested_object" "$key")
echo " $result " # Expected: Alice


nested_object='{"data":{"students":[{"id":1,"name":"Tom"},{"id":2,"name":"Sara"}]}}'
key="data/students/0/id"
result=$(getValueByKey "$nested_object" "$key")
echo " $result " # Expected: 1


nested_object='{"company":{"departments":[{"name":"Sales","employees":[{"id":1,"name":"John"},{"id":2,"name":"Alice"}]},{"name":"Marketing","employees":[{"id":3,"name":"Bob"},{"id":4,"name":"Emily"}]}]}}'
key="company/departments/1/employees/0/name"
result=$(getValueByKey "$nested_object" "$key")
echo " $result " # Expected: Bob


nested_object='{"a":{"b": {"c": {"d": {"e": {"f": {"g": {"h": {"i": {"j": "k"}}}}}}}}}, "x": {"y": {"z": "w"}}}'
key="a/b/c/d/e/f/g/h/i/j"
result=$(getValueByKey "$nested_object" "$key")
echo " $result " # Expected: k
