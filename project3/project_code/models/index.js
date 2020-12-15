const mongoose = require('mongoose');
const url = 'mongodb://localhost:27017/project3';
mongoose.connect(url,{ 
    useNewUrlParser: true, 
    useUnifiedTopology: true,
    useCreateIndex: true,
    useFindAndModify: false
},(err)=>{
    if(err){
        console.log(err);
    }
    else{
        console.log('Successfully started');
    }

 
});
const Course = require("./project.model");