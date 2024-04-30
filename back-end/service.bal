import ballerina/http;
import ballerina/io;
import ballerinax/mongodb;

public type PushEvent record {|
    string repository;
    string after;
    string pusher;
|};

mongodb:Client mongodbEp = check new (config = {
    connection: "mongodb+srv://hasithatest20:lVPcpyX03D1mriZ6@cluster0.nbmdmmk.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
});

service / on new http:Listener(9090) {

    // This function responds with `string` value `Hello, World!` to HTTP GET requests.
    resource function get health() returns json {
        return {
            code: 200,
            message: "I'm healthy!"
        };
    }

    resource function post events(PushEvent event) returns json|error {
        io:println(event);
        mongodb:Database database = check mongodbEp->getDatabase("tesla");
        mongodb:Collection collection = check database->getCollection("github");
        mongodb:Error? insertOne = collection->insertOne(event);
        if insertOne is mongodb:Error {
            io:println(insertOne);
        }
        return {
            code: 200,
            message: "I received your message"
        };
    }
}
