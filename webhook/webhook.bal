import ballerina/http;
import ballerina/io;
import ballerina/os;
import ballerinax/trigger.github;

configurable github:ListenerConfig config = ?;

listener http:Listener httpListener = new (8090);
listener github:Listener webhookListener = new (config, httpListener);
service github:PushService on webhookListener {
    remote function onPush(github:PushEvent payload) returns error? {
        io:println("HAHA");
        string serviceUrl = os:getEnv("SERVICE_URL");
        string consumerKey = os:getEnv("CONSUMER_KEY");
        string consumerSecret = os:getEnv("CONSUMER_SECRET");
        string tokenUrl = os:getEnv("TOKEN_URL");
        http:Client httpEp = check new (url = serviceUrl, config = {
            auth: {
                tokenUrl: tokenUrl,
                clientId: consumerKey,
                clientSecret: consumerSecret
            }
        });
        http:Response|http:ClientError res = httpEp->get("/greeting");
        if res is http:Response {
            io:println(res.getJsonPayload());
        } else {
            io:println(res.cause());
        }
    }
}

service /ignore on httpListener {
}
