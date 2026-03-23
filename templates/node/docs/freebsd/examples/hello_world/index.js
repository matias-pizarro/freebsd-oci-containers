// index.js

// Require would make available the
// express package to be used in
// our code
const express = require("express");

// Creates an express object
const app = express();

// It listens to HTTP get request.
// Here it listens to the root i.e '/'
app.get("/", (req, res) => {

  // Using send function we send
  // response to the client
  // Here we are sending html
  res.send("<h1> Hello World! </h1>");
});

// It configures the system to listen
// to port 8888. Any number can be
// given instead of 8888, the only
// condition is that no other server
// should be running at that port
app.listen(8888, () => {

  // Print in the console when the
  // servers starts to listen on 8888
  console.log("Listening to port 8888");
});
