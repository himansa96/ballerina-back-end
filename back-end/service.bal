import ballerina/http;
import ballerina/io;

service / on new http:Listener(9090) {

    // This function responds with `string` value `Hello, World!` to HTTP GET requests.
    resource function get greeting() returns string {
        io:println("SEWEE");
        return "Hello, World!";
    }
}
