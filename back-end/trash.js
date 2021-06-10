

// auth(body):
//   if body.user is in database:
//         body.user.login()
//   else:
//      body.user.register
//      body.user.login()
//  return user.token()


// var user = User({id: "testId", password: "testPassword"});
// user.save(function(err, user){
//     if (err){
//         console.log("Something went wrong");
//         console.log(err.message);
//     }
//     console.log(user);
// });

// User.find(function(err, users){
//     console.log(users);
// });

// console.log(req.body.id.toString());
// console.log(req.body.password.toString());
//res.send("Success");