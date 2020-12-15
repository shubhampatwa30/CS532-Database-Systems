const express = require('express');
const mongoose = require('mongoose');

const searcher = express.Router();
const projectModel =  mongoose.model("project");

searcher.get("/",(req,res)=>{

    res.render("search");
})


// Find by ID
searcher.get("/by_id",(req,res)=>{

    res.render("by_id");
})

searcher.post("/by_id",(req,res)=>{
var id_ = req.body.id;

  projectModel.find({ "id": id_},(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by name
searcher.get("/by_name",(req,res)=>{

    res.render("by_name");
})

searcher.post("/by_name",(req,res)=>{
   
var name_ = req.body.name;


  projectModel.find({ "name": name_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by date
searcher.get("/by_date",(req,res)=>{

    res.render("by_date");
})

searcher.post("/by_date",(req,res)=>{

    var date_ = req.body.date;


  projectModel.find({ "date": date_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by manner_of_death
searcher.get("/by_manner_of_death",(req,res)=>{

    res.render("by_manner_of_death");
})

searcher.post("/by_manner_of_death",(req,res)=>{
var manner_of_death_ = req.body.manner_of_death;


  projectModel.find({ "manner_of_death": manner_of_death_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by Armed Type
searcher.get("/by_armed_type",(req,res)=>{

    res.render("by_armed_type");
})

searcher.post("/by_armed_type",(req,res)=>{
var armed_type_ = req.body.armed_type;


  projectModel.find({ "armed": armed_type_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by Age Factor
searcher.get("/by_age",(req,res)=>{

    res.render("by_age");
})

searcher.post("/by_age",(req,res)=>{
   
var age_ = req.body.age;


  projectModel.find({ "age": age_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by Gender
searcher.get("/by_gender",(req,res)=>{

    res.render("by_gender");
})

searcher.post("/by_gender",(req,res)=>{
var gender_ = req.body.gender;


  projectModel.find({ "gender": gender_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);


//Find by Race
searcher.get("/by_race",(req,res)=>{

    res.render("by_race");
})

searcher.post("/by_race",(req,res)=>{
    
var race_ = req.body.race;


  projectModel.find({ "race": race_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs.length);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by City
searcher.get("/by_city",(req,res)=>{

    res.render("by_city");
})

searcher.post("/by_city",(req,res)=>{
var city_ = req.body.city;


  projectModel.find({ "city": city_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by State
searcher.get("/by_state",(req,res)=>{

    res.render("by_state");
})

searcher.post("/by_state",(req,res)=>{
var state_ = req.body.state;


  projectModel.find({ "state": state_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by Signs of Mental Illness
searcher.get("/by_signs_of_mental_illness",(req,res)=>{

    res.render("by_signs_of_mental_illness");
})

searcher.post("/by_signs_of_mental_illness",(req,res)=>{
var signs_of_mental_illness_ = req.body.signs_of_mental_illness;


  projectModel.find({ "signs_of_mental_illness": signs_of_mental_illness_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by Signs of Threat Level
searcher.get("/by_threat_level",(req,res)=>{

    res.render("by_threat_level");
})

searcher.post("/by_threat_level",(req,res)=>{

var threat_level_ = req.body.threat_level;


  projectModel.find({ "threat_level": threat_level_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
           // console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by Signs of Flee Status
searcher.get("/by_flee_status",(req,res)=>{

    res.render("by_flee_status");
})

searcher.post("/by_flee_status",(req,res)=>{
var flee_ = req.body.flee;


  projectModel.find({ "flee": flee_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by Body Camera
searcher.get("/by_body_camera",(req,res)=>{

    res.render("by_body_camera");
})

searcher.post("/by_body_camera",(req,res)=>{
var body_camera_ = req.body.body_camera;


  projectModel.find({ "body_camera": body_camera_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);

//Find by arms_category
searcher.get("/by_arms_category",(req,res)=>{

    res.render("by_arms_category");
})

searcher.post("/by_arms_category",(req,res)=>{

var arms_category_ = req.body.arms_category;


  projectModel.find({ "arms_category": arms_category_ },(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
            console.log(docs);
         
        }
        else{
            res.send(err);
        }
     }
    )
}
);



//Find by multiple filters
searcher.get("/by_multiple_filters",(req,res)=>{

    res.render("by_multiple_filters");
})

searcher.post("/by_multiple_filters",(req,res)=>{


    if(req.body.id == ''){
        delete req.body.id;
    }
    if(req.body.name == ''){
        delete req.body.name;
    }
    if(req.body.date == ''){
        delete req.body.date;
    }
    if(req.body.manner_of_death == ''){
        delete req.body.manner_of_death;
    }
    if(req.body.armed == ''){
        delete req.body.armed;
    }
    if(req.body.age == ''){
        delete req.body.age;
    }
    if(req.body.gender == ''){
        delete req.body.gender;
    }
    if(req.body.race == ''){
        delete req.body.race;
    }
    if(req.body.city == ''){
        delete req.body.city;
    }
    if(req.body.state == ''){
        delete req.body.state;
    }
    if(req.body.signs_of_mental_illness == ''){
        delete req.body.signs_of_mental_illness;
    }
    if(req.body.threat_level == ''){
        delete req.body.threat_level;
    }
    if(req.body.flee == ''){
        delete req.body.flee;
    }
    if(req.body.body_camera == ''){
        delete req.body.body_camera;
    }
    if(req.body.arms_category == ''){
        delete req.body.arms_category;
    }


console.log(req.body);
  projectModel.find(req.body,(err, docs)=>{ 
        if(!err){
            res.render("list",{data :docs});
           // console.log(docs);
         
        }
        else{
         res.send(err);
        }
     }
    )
    
}
);

module.exports = searcher;