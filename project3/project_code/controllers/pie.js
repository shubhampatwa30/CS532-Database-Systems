const express = require('express');
const mongoose = require('mongoose');

const pie = express.Router();
const pieSchema =  mongoose.model("pieSchema");

pie.get("/",(req,res)=>{

    res.render("pie");
})

pie.post("/",(req,res)=>{
   
            pieSchema.aggregate([
                {
                    $match : { state : req.body.state}
                },
                { $group: { _id: "$race", count: { $sum: 1 } } }
             ],(err,docs)=>{
                 var total = 0;
                 for(var i = 0;i<docs.length;i++){
                     total += docs[i].count;
                     
                 }
                 for(var i = 0;i<docs.length;i++){
                    docs[i].count = docs[i].count*100/total;
                   
                    
                }


                 res.render("displayAnalysis",{data : docs});   
             }
            ); 


           
    
    }
    );
    
   



module.exports = pie;
