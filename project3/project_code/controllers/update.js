const express = require('express');
const mongoose = require('mongoose');

const updater = express.Router();
const projectModel =  mongoose.model("project");

updater.get("/",(req,res)=>{

    res.render("update");
})

updater.post("/",(req,res)=>{
    var id_orig = req.body.id_orig;
    var id_new  = req.body.id_new;
var name_ = req.body.name;
var date_ = req.body.date;
var manner_of_death_ = req.body.manner_of_death;
var armed_ = req.body.armed;
var age_ = req.body.age;
var gender_ = req.body.gender;
var race_ = req.body.race;
var city_ = req.body.city;
var state_ = req.body.state;
var signs_of_mental_illness_ = req.body.signs_of_mental_illness;
var threat_level_ = req.body.threat_level;
var flee_ = req.body.flee;
var body_camera_ = req.body.body_camera;
var arms_category_ = req.body.arms_category;

if(req.body.check){
   
    projectModel.updateOne({ "id":id_orig, },{"id": id_new, "name" : name_, "date":date_ , "manner_of_death" : manner_of_death_, "armed" : armed_ , "age" : age_, "gender":gender_, "race": race_, "city": city_, "state": state_, "signs_of_mental_illness": signs_of_mental_illness_, "threat_level" : threat_level_, "flee":flee_, "body_camera": body_camera_, "arms_category": arms_category_}, { upsert: true },(err, docs)=>{ 
        if(!err){
            res.send("Update Successful");
         
        }
        else{
            res.send(err);
        }
     }
    )
}

else{
   
    projectModel.updateOne({ "id":id_orig, },{"id": id_new, "name" : name_, "date":date_ , "manner_of_death" : manner_of_death_, "armed" : armed_ , "age" : age_, "gender":gender_, "race": race_, "city": city_, "state": state_, "signs_of_mental_illness": signs_of_mental_illness_, "threat_level" : threat_level_, "flee":flee_, "body_camera": body_camera_, "arms_category": arms_category_},(err, docs)=>{ 
        if(!err){
            
            if(docs.nModified == 0){
                res.send("No Document with id : "+ id_orig+ " found");
            }
            else{
                res.send("Successfully updated. ");
            }
         
        }
        else{
            res.send(err);
        }
     }
    )
}


})

module.exports = updater;
