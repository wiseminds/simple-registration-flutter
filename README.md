# challenge

 Mobile Engineer Use Case (Flutter)

A registration flow demo

App Structure
## setup 
- to run app, please create a .env.dart file from .env.example.dart, this file should be inside the `lib` directory.

Flutter is an interesting framework to work with, but requires a solid folder structure to build a scalable application. Based on research and years of experience, I have come to adopt a folder structure I use in most of my projects.

The provided endpoint to fetch states and city was down when I needed to use it, I had to look for an alternative.


## lib
- under the lib directory, below is the project structure
### constants 
- this is a folder that holds static constants like strings and dimension used in the app.

### views 
- this holds all screens contained in the app.

### widgets 
- this holds all reusable widgets used in the app.

### models 
- this holds all data models used in the app.

### services 
- this holds all data services used in the app.

### data 
- this is also known as the data repository, it handles all access to data including cache and remote data. it makes decision based on parameters passed in to either fetch from cache or fetch from a remote source.
- this library is a custom http library I built to handle a lot of the boilerplate involved in data access including features like parsing JSON into specified dart model, uploading a file.
- you can use any http library available (http, dio, chopper, e.t.c) to handle actual http call,
just make sure to implement `ApiProvider` and implement all methods.
