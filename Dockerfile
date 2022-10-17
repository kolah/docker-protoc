FROM alpine:3.16 as builder

RUN apk add --no-cache git cmake build-base

ARG VERSION=v1.50.0

RUN git clone -b ${VERSION} https://github.com/grpc/grpc --recursive --shallow-submodules --depth=1

RUN cd grpc \
    && mkdir -p cmake/build \
    && cd cmake/build \
    && cmake ../.. \
    && cat Makefile \
    && make protoc grpc_plugin_support grpc_php_plugin grpc_cpp_plugin grpc_csharp_plugin grpc_node_plugin grpc_objective_c_plugin grpc_python_plugin grpc_ruby_plugin \
    && mkdir -p /build/bin \
    && cp grpc_php_plugin grpc_cpp_plugin grpc_csharp_plugin grpc_node_plugin grpc_objective_c_plugin grpc_python_plugin grpc_ruby_plugin /build/bin/ \
    && cp third_party/protobuf/protoc /build/bin \
    && cd ../../.. \
    && mkdir -p /build/include/google/protobuf/compiler \
    && cd grpc/third_party/protobuf/src/google/protobuf \
    && cp any.proto api.proto descriptor.proto duration.proto empty.proto field_mask.proto source_context.proto struct.proto timestamp.proto type.proto wrappers.proto /build/include/google/protobuf/ \
    && cp compiler/plugin.proto /build/include/google/protobuf/compiler \
    && rm -rf grpc

FROM alpine:3.16

RUN apk add --no-cache libstdc++

COPY --from=builder /build/bin/* /bin/
COPY --from=builder /build/include/google /usr/local/include/google

ENTRYPOINT ["/bin/protoc", "-I/usr/local/include"]
