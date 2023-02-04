//import weapons
import w from "../../assets/weapons/weapon.json";
import playerSprite from "../assets/sprites/playerSprites/test_sprite.png";

class Player {
    static x = 0;
    static y = 0;
    static speed = 2; //speed of player
    speedX = 0;
    speedY = 0;
    height = 0;
    width = 0;
    weaponAngle = 0;
    spriteSRC = playerSprite;

    //default
    constructor(w,h,pX,pY) {
        this.height = h;
        this.width = w;
        this.x = pX;
        this.y = pY;
        this.spriteSRC = playerSprite;
    };

    constructor() {
        this.height = 20;
        this.width = 20;
        this.x = 50;
        this.y = 50;
        this.spriteSRC = playerSprite;
    };

    getPlayer() {
        return (this.spriteSRC+","+this.x+","+this.y+","+this.width+","+this.height);
    };

    getWeapon() {
        return (this.x+","+this.y+","+this.angle);
    };

    update() {

    };

    changeDir(dirX,dirY) {
        this.speedX += dirX;
        this.speedY += dirY;
    };

    shoot(coordX,coordY) {

    };

    rotateWeapon(angle) {

    };
}
