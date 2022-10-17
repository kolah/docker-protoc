# kolah/protoc 
Light docker images for generating protocol buffer definitions.

`docker pull kolah/protoc`

This repository contains a wrapper script `protoc` that will run docker image with current directory as a working directory.
Synopsis is the same as the original `protoc` command:

```bash
$ protoc --proto_path=examples/protos \
  --php_out=examples/php/route_guide \
  --grpc_out=examples/php/route_guide \
  --plugin=protoc-gen-grpc=/bin/grpc_php_plugin \
  ./examples/protos/route_guide.proto
```

GRPC plugins listed below are stored in `/bin`:

* `grpc_csharp_plugin`
* `grpc_cpp_plugin`
* `grpc_node_plugin`
* `grpc_objective_c_plugin`
* `grpc_php_plugin`
* `grpc_python_plugin` 
* `grpc_ruby_plugin`
