const express = require('express');
const mongoose = require('mongoose');

const remover = express.Router();
const projectModel =  mongoose.model("project");

remover.get("/",(req,res)=>{

    res.render("remove");
})

remover.post("/",(req,res)=>{
    var id_ = req.body.id;
 

   
    projectModel.deleteOne({ "id":id_},(err, docs)=>{ 
        if(!err){
            if(docs.deletedCount!=0){
            res.send("Delete Successful");
            console.log(docs);}
            else{
                res.send("Id not found");
                console.log(docs);
            }
        }
        else{
            res.send(err);
        }
     }
    )


})

module.exports = remover;
