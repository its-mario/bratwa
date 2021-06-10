const StreamChat = require('stream-chat').StreamChat;
const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

// import the url for acces database also import keys for accesing getStream
const configs = require('./configs.js');

const User = require('./models/user.js');


// database initialization
mongoose.connect(configs.mongoUrl, {useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true });
const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function() {
  console.log('MongoDB with logins and passwords connected!');
});

// stream-chat client inintialization 
const client = StreamChat.getInstance( configs.getStreamApiKey, configs.getStreamToken).then(()=>{
    console.log("");
}); 

// express app initiliaztion
const app = express();
//const port = 3000;
const port = process.env.PORT || 5000;

//settings
app.use(express.urlencoded({ extended: false }))
app.use(express.json())

// log midleware
app.use(function(req, res, next){
    console.log(req.method.toString(), req.path.toString());
    next();
})

app.get('/', function(req, res){
    res.send("This is backend for a md_messenger author: Lupei Marius");
});

async function registredUser(req, res, next){
    //looking MongoDB for this user
    var dbUser = await User.findOne({id: req.id} ,function(err, users){
        if (err) {
            res.status(500);
            throw new Error(err);
        } 
    });

    req.dbUser = dbUser;

    if (dbUser){
        console.log("This user exists in db");
        next();
    } else {
        console.log("This user doesn't exists.");
        // create user

        user = new User({
            id: req.id,
            password: req.password,
        });
        req.dbUser = await user.save(
        //     function(err, user){
        //     if (err){
        //         throw new Error(err);  
        //     } else {
        //         console.log(`The user <${user.id}> successfully saved in database...`);
        //     }
        // }
        );
        console.log(`The db user <${req.dbUser}>`);  
    }
    next();
}

function createToken(req, res, next){
    console.log(`Creating token for userId: <${req.id}>`);
    
    if(req.dbUser.password == req.password){
        var token = client.createToken(req.id);
        console.log(token.toString());
        res.status(200);
        res.json(
            {
                "idUser" : req.id, 
                "token" : token,
            }
        );
    } else {
        res.status(400);
        res.send("The password is incorrect! Go fuck yourself!!!"); 
        console.log("The provided password was incorect...");
    }

}

// auth route (logIn , SingUp)
app.post('/auth', [async function(req, res ,next){
    
    
    req.id = req.body.id;
    req.password = req.body.password;

    //log the authentication tries
    console.log(` <${req.id}> trying to logIn with password:<${req.password}> `);
    next();
    
    
}, registredUser , createToken]);

app.get('/logIn', async function(req, res){

    req.id = req.headers.id;
    req.password = req.headers.password;
    console.log("Sing In User");

    var dbUser = await User.findOne({id: req.id} ,function(err, users){
        if (err) {
            res.status(500);
            throw new Error(err);
        } 
    });

    req.dbUser = dbUser;
    if (dbUser){
        console.log(`Creating token for userId: <${req.id}>`);
    
        if(req.dbUser.password == req.password){
            var token = client.createToken(req.id);
            console.log(token.toString());
            res.status(200);
            res.json(
                {
                    "id" : req.id, 
                    "token" : token,
                }
            );
        } else {
            res.status(400);
            res.json({"error": "The id or the password was incorrect"}); 
            console.log("The provided password was incorect...");
        }
    } else {
        res.status(400);
        res.json({"error": "this user dosen't exits in db"});
    }
});



app.post('/register', async function(req, res){

    // All params that are present in UI right now
    req.id = req.body.id;
    req.password = req.body.password;
    req.email = req.body.email;
    req.name = req.body.name;
    console.log("Register User");


    var dbUser = await User.findOne({id: req.id} ,function(err, users){
        if (err) {
            res.status(500);
            throw new Error(err);
        } 
    });

    if (dbUser){
        console.log("This user exists in db");
        res.status(400);
        res.json({"error": "a user with this id exits try to change the id"});
    } else {
        console.log("This user doesn't exists.");
        // create user

        user = new User({
            id: req.id,
            password: req.password,
            email: req.email,
            name: req.name
        });
        req.dbUser = await user.save(
            function(err, user){
            if (err){
                throw new Error(err);  
            } else {
                console.log(`The user <${user.id}> successfully saved in database...`);
            }
        }
        );
        //console.log(`The db user <${req.dbUser}>`); 
        res.status(200);
        res.send('success'); 
    }
    
});


app.use(function(err,req, res, next){
    res.status(500).send(err.message);
    console.log(err.toString());
});

app.listen(port, function(){
    console.log("The server started !!");
});

