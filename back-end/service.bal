import ballerina/grpc;

listener grpc:Listener grpcListener = new (9090);

configurable string ENDPOINT = ?;

@grpc:Descriptor {value: ENDPOINT}
service "Greeter" on grpcListener {

    remote function sayHello(HelloRequest value) returns HelloReply|error {
        return {message: "Hello " + value.name};
    }
}