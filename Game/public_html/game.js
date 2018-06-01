/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function logout()
{
    sessionStorage.clear();
    window.location="login.html";
}
function home()
{
    window.location="index.html";
}
function games()
{
    window.location="games.html";
}
function displayNextImage()
{
    x = (x === images.length - 1) ? 0 : x + 1;
    document.getElementById("img").src = images[x];
}
function startAdvertisement()
{
    setInterval(displayNextImage, 30000);
}
var images = [], x = -1;
images[0] = "IMG/image1.jpg";
images[1] = "IMG/image2.jpg";
images[2] = "IMG/image3.jpg";
images[3] = "IMG/image4.jpg";
images[4] = "IMG/image5.jpg";
images[5] = "IMG/image6.jpg";


var startDateTime;
function new_game()
{
    location.reload();
       
    //return dateTime;
    //alert(dateTime);
    add_record();
}
function quit_game()
{
    window.location="index.html";
}
function add_record()
{
    var now     = new Date(); 
    var year    = now.getFullYear();
    var month   = now.getMonth()+1; 
    var day     = now.getDate();
    var hour    = now.getHours();
    var minute  = now.getMinutes();
    var second  = now.getSeconds(); 
    
    if(month.toString().length === 1) {
        var month = '0'+month;
    }
    if(day.toString().length === 1) {
        var day = '0'+day;
    }   
    if(hour.toString().length === 1) {
        var hour = '0'+hour;
    }
    if(minute.toString().length === 1) {
        var minute = '0'+minute;
    }
    if(second.toString().length === 1) {
        var second = '0'+second;
    }   
    startDateTime = year+'/'+month+'/'+day+' '+hour+':'+minute+':'+second;
    
    var playerName=sessionStorage.getItem('sessionFirstname');
    var existingRecords = JSON.parse(localStorage.getItem("allRecords"));
    if(existingRecords === null)
        existingRecords = [];
    
    var record = {
                playername:playerName,
                start:startDateTime,
                end:" ",
                word:" ",
                result:" "
            };
            //alert("hello");
            //alert(record);
    localStorage.setItem("record", JSON.stringify(record));
    // Save allEntries back to local storage
    existingRecords.push(record);
    localStorage.setItem("allRecords", JSON.stringify(existingRecords));
}