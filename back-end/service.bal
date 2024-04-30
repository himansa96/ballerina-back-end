import ballerina/http;
import ballerina/io;

public type PushEvent record {|
    string repository;
    string after;
    string pusher;
|};

service / on new http:Listener(9090) {

    // This function responds with `string` value `Hello, World!` to HTTP GET requests.
    resource function get health() returns json {
        return {
            code: 200,
            message: "I'm healthy!"
        };
    }

    resource function post events(PushEvent event) returns json {
        io:println(event);
        return {
            code: 200,
            message: "I received your message"
        };
    }
}
