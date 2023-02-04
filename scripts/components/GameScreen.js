class GameScreen {
    static mouseX;
    static mouseY;
    gameArea;
    ctx;
    static frameNo = 0;

    constructor (w,h) {
        this.gameArea = document.createElement("canvas");
        this.gameArea.style.width = w;
        this.gameArea.style.height = h;
    }

    constructor() {
        this.gameArea = document.createElement("canvas");
    }

    //start the game
    getScreen() {
        return this.gameArea;
    }



    getCTX() {
        return this.gameArea.canvas.getContext("2d");
    }

    update() {
        this.clear(); 

    }
    
    pause() {

    }

    unpause() {

    }

    clear() {
        this.gameArea.context.clearRect(0,0,gameArea.style.width,gameArea.style.height)
    }
}