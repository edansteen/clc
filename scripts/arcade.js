import "./components/GameScreen.js";
import "./components/Player.js";

var gameOver = false;
var score = 0;

// current position of player
var playerX = document.body.width/2;
var playerY = document.body.height/2;
var playerHeight = 64;
var playerWidth = 48;
// current position of mouse
var mouseX = playerX+1;
var mouseY = playerY;

var screen = new GameScreen();
var player = new Player();

var gameArea = screen.getScreen();

document.body.appendChild(gameArea);

document.body.onload = function main() {
    setup();
    while (!gameOver) {
        draw();
        logic();
        setTimeout(20); //delay
    }
}

function setup() {
    //setupGame
    
    
};

function draw() {
    //put stuff on the screen
};

function logic() {
    gameOver= true;
};

/* CONTROLS */

//fire controls
document.getElementById("gameArea").addEventListener("onclick", function() {
    //fire bullet to direction of mouse

});

//on unclick, play hammer reload sound and set chamberEmpty to false

//aim controls
document.getElementById("gameArea").addEventListener("onmousemove", function(event) {
    //get current position of mouse
    mouseX = event.clientX;
    mouseY = event.clientY;
});

//movement controls
window.onkeydown = function(e) {
    //move character
    switch(e.key) {
        case 'w':
            Player.speedY--;
            break;
        case 'a':
            Player.speedX--;
            break;
        case 's':
            Player.speedY++;
            break;
        case 'd':
            Player.speedX++;
            break;
        case 32: //space
            Player.shoot(mouseX,mouseY);
            break;
        case 27:    //escape
            break;
        default: 
            break;
    } 
}

window.onkeyup = function(e) {
    //move character
    switch(e.key) {
        case 'w':
        case 's':
            Player.speedY = 0;
            break;
        case 'a':
        case 'd':
            Player.speedX = 0;
            break;
        case 32: //space
            break;
        case 27:    //escape
            break;
        default: 
            break;
    } 
}