var gameOver = false;
//current position of player
var playerX = document.body.width/2;
var playerY = document.body.height/2;
//player direction of movement
var dirX = 0;
var dirY = 0;
//mouse position
var mouseX = 0;
var mouseY = 0;

document.body.onload = function main() {
    setup();
    while (!gameOver) {
        draw();
        logic();
    }
    console.log("game over");
}

var gameCanvas = {
    //
}

//the arm that holds the weapon
function PlayerWeapon (width,height,x,y,spriteSRC,angle) {
    this.width = width;
    this.heigh = height;
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.spriteSRC = spriteSRC;
    this.update() = function() {
        //update
    }
}

function Player(width,height,spriteSRC,x,y) {
    this.width=width;
    this.height=height;
    this.x = x;
    this.y = y;
    this.speedX = 0;
    this.speedY = 0;
    this.classList.add("test");
    this.update() = function() {
        //update
    }
}

//fire controls
document.addEventListener(onclick) = () => {
    //fire bullet to direction of cursor
}

//aim controls
document.addEventListener(onmousemove) = () => {
    //get current position of mouse
}

//movement controls
document.addEventListener(onkeydown) = () => {
    //move character 
}

function setup() {
    //setupGame
};
function draw() {

};
function logic() {
    gameOver= true;
};
