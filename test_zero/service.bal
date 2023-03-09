import ballerina/http;

type Movie readonly & record{
    string title;
    string director;
};

table<Movie> key(title) movies = table [
    {title: "Moonrise Kingdom", director:"Wes Anderson"},
    {title: "Spirited Away", director: "Hayao Miyazaki"}
];

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get greeting(string name) returns string|error {
        // Send a response back to the caller.
        if name is "" {
            return error("name should not be empty!");
        }
        return "Hello, " + name;
    }

    resource function get movies() returns Movie[]{
        return movies.toArray();
    }

    resource function post movies(@http:Payload Movie movie) returns Movie[]{
        movies.add(movie);
        return movies.toArray();
    }

    
}
