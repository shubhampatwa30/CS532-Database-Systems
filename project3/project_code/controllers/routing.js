const express = require('express');
const mongoose = require('mongoose');
const router = express.Router();
const projectModel =  mongoose.model("project");
const searchController = require("./search");
const updateController = require("./update");
const removeController = require("./remove");
const pieController = require("./pie");

router.get("/",(req,res)=>{

    res.send("Router");
 
    

})

router.get("/create",(req,res)=>{

    res.render("create");
})

router.post("/create",(req,res)=>{
    var length =1;
    projectModel.find({ "id": req.body.id},(err, docs)=>{ 
        if(!err){
            
           // console.log(docs);
         length = (docs.length);
        }
        else{
            res.send(err);
        }
     }
    )
    if(length == 0){

    var project = new projectModel();
    
    project.id  = req.body.id;
project.name = req.body.name;
project.date = req.body.date;
project.manner_of_death = req.body.manner_of_death;
project.armed = req.body.armed_type;
project.age = req.body.age;
project.gender= req.body.gender;
project.race = req.body.race;
project.city = req.body.city;
project.state = req.body.state;
project.signs_of_mental_illness = req.body.signs_of_mental_illness;
project.threat_level = req.body.threat_level;
project.flee = req.body.flee;
project.body_camera = req.body.body_camera;
project.arms_category = req.body.arms_category;


    project.save((err,docs) => {
            if(!err){
                res.send("Insert Successful");
                
            }
            else{
                res.send(err);
            }
    });
  
    
    }
    else{
        res.send("Id already exists");
    }


});



router.get("/list",(req,res)=>{
  projectModel.find((err, docs)=>{ 
    if(!err){
        res.render("list",{data :docs});
    }
    else{
        res.send(err);
    }
 })});

router.use("/search",searchController);
router.use("/update",updateController);
router.use("/remove",removeController);
router.use("/pieanalysis",pieController);


module.exports = router;