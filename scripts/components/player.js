//import weapon
//import player spritesheet
//splice player spritesheet

export function Player(width,height,spriteSRC,x,y) {
    this.width=width;
    this.height=height;
    this.x = x;
    this.y = y;
    this.speedX = 0;
    this.speedY = 0;
    this.spriteSRC = spriteSRC;
    this.classList.add("test");
    new PlayerWeapon(width,height,x,y,spriteSRC,angle);
    this.update() = function() {
        //update
    }
}

//the arm that holds the weapon
//rect that rotates around player x and y values
function PlayerWeapon (width,height,x,y,spriteSRC,angle) {
    this.width = width;
    this.height = height;
    this.x = x;
    this.y = y;
    this.angle = angle; //0-360 degrees
    this.sprite = spriteSRC;
    this.moveTo(coordX, coordY) = function() {
        this.x = coordX;
        this.y = coordY;
    }
    this.rotate() = function() {
        //rotate around x and y coordinates
    }
}

//fire controls
document.body.addEventListener(onclick) = () => {
    //fire bullet to direction of cursor
}

//aim controls
document.body.addEventListener(onmousemove) = () => {
    //get current position of mouse
}

//movement controls
document.body.addEventListener(onkeydown) = () => {
    //move character
    switch(e) {
        case 'w':
            break;
        case 'a':
            break;
        case 's':
            break;
        case 'd':
            break;
        case 32:
            break;
        default: 
            break;
    } 
}