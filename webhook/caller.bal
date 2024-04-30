import ballerina/grpc;

grpc:Client grpcEp = check new (url = "");
