const mongoose = require('mongoose');



const userSchema = new mongoose.Schema({
    id: {
        required: true,
        type: String,
        unique: true
    },
    password: {
        required: true,
        type: String
    },
    name: {
        type: String
    },
    email: {
        type: String,
        required: true,
        unique: true
    }

});

const User = mongoose.model('user', userSchema);

module.exports = User;