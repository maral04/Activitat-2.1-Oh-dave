//Primera llei, el cotxe dret té preferència. El que ve d'amunt es para sempre i comprova que no hi hagi cap cotxe a punt.
//Segona llei, els cotxes suden de tot i només es paren si estàn MOOOOOLT aprop de xocar.

Car myCar, myCar2;
Carretera myCarretera;
boolean ojo = false;
boolean debugactiu = true;
int distanciaPreventiva;
int multPreventiu;
var onlyOnetime = true;

void setup() {
  size(1024, 512);
  myCarretera = new Carretera(color(145, 145, 145), 0, (height/2)-40, 2); //Direcció 2, dreta.
  myCarretera2 = new Carretera(color(145, 145, 145), (width/2)-40, 0, 3); //Direcció 3, Aball.
  myCar = new Car(color(0, 225, 45), 0, (height/2)-20, 5, 2); //El verd.
  myCar2 = new Car(color(255, 0, 0), (width/2)-20, 0, 2, 3); //El vermell.
}

void draw() {
  background(235, 235, 235);
  myCarretera.display();
  myCarretera2.display();
  myCar.display();
  myCar.drive();
  myCar2.display();
  if (ojo != true) {
    myCar2.drive();
  }
  lleiNais(2);
  fill(myCar.c);
  text("Velocitat del cotxe Verd: "+myCar.xspeed, 25, 35);
  fill(#FF6EF3); //Rosa cantó
  text("Distància preventiva: "+distanciaPreventiva, 25, 65);
  fill(0);
  text("c = captura de pantalla.",width-175,35);
  text("t = línies debugg.",width-175,65);
  text("+ o - = SpeedUp o Down.",width-175,95);
}

void lleiNais(int tipusLlei) {
  if (tipusLlei == 1) {
  } else {
    if (tipusLlei == 2) {
      if (myCar.xspeed >= 9) {
        text("A partir de 9, vas a moríl!", 185, 45);
        //Només ho fa quan puja per primera vegada de 8 sense haver baixat d'aquest.
        if(onlyOnetime == true){
          //multPreventiu = multPreventiu+(myCar.xspeed/10);
          multPreventiu = 1.7;
          onlyOnetime = false;
        }
      }else{
        //Si es fals vol dir que ha baixat de 8 abans havent pujat..
        if(onlyOnetime == false){
          onlyOnetime = true;
        }
        //multPreventiu = myCar.xspeed;
        multPreventiu = 1.5;
      }
      distanciaPreventiva = parseInt(45 * (myCar.xspeed * multPreventiu));
      if (debugactiu == true) {
        fill(255,255,255);
        rect( (myCar.xpos),height/2-40,2,80);
        rect( myCar.xpos+distanciaPreventiva,height/2-40,2,80);
        rect( ((width/2)-myCar)-distanciaPreventiva.carW,height/2-40,2,80);
        rect((width/2)-40,(height/2)-myCar2.carH-myCar2.carH,80,2);
        rect((width/2)-40,(height/2)-myCar2.carH,80,2);
        //rect((width/2)-40,(height/2)+myCar2.carH,80,0);
        rect( (width/2)-myCar.carW,height/2-40,2,80);
        rect( (width/2)+myCar.carW,height/2-40,2,80);
        
        //console.log((width/2)-myCar.carW-distanciaPreventiva);
        //console.log((width/2)+myCar.carW); //572px
      }

      if (
      (myCar2.ypos)+myCar2.carH <= (height/2)-myCar2.carH &&
        (myCar2.ypos)+myCar2.carH >= (height/2)-myCar2.carH &&
        //(myCar.xpos)-myCar.carW >= (width/2)-distanciaPreventiva &&
      //(myCar.xpos)-distanciaPreventiva <= (width/2)-myCar.carW
      //(myCar.xpos+myCar.carW)+distanciaPreventiva <= (width/2)+myCar.carW
      myCar.xpos+distanciaPreventiva >= (width/2)-myCar.carW &&
      myCar.xpos <= (width/2)+myCar.carW
    
      /* (myCar.xpos)-20 <= (myCar.xpos)+30 &&
       (myCar2.xpos)+20 >= (myCar.xpos)+20*/
      ) {
        if (debugactiu == true) {
         //console.log("Parat.");
          //console.log((myCar.xpos)-distanciaPreventiva);
        }
        //console.log(((myCar2.xpos)-20)+" "+(myCar2.xpos)+20);
        ojo = true;
      } else {
        //if ((myCar.xpos)-50 >= (width/2)+100) {
          //console.log(myCar.xpos+" "+myCar2.xpos);
          ojo = false;
        //}
      }
    }
  }
}

static class Car {
  color c;
  int xpos;
  int ypos;
  int xspeed;
  int direccioC;
  int carW;
  int carH;

  Car(color tempC, int tempXpos, int tempYpos, int tempXspeed, int direccio) {
    c = tempC;   
    xpos = tempXpos;   
    ypos = tempYpos;   
    xspeed = tempXspeed;
    direccioC = direccio;
    if (direccioC == 2) {
      carW = 60;
      carH = 40;
    } else {
      if (direccioC == 3) {
        carH = 60;
        carW = 40;
      }
    }
  }

  void display() {

    stroke(0);
    fill(c);
    if (direccioC == 2) {
      rect(xpos, ypos, carW, carH);
    } else {
      if (direccioC == 3) {
        rect(xpos, ypos, carW, carH);
      }
    }
  }

  void drive() {
    if (direccioC == 2) {
      xpos = xpos + xspeed;

      if (xpos >= width) {
        xpos = 0;
      }
    } else {
      if (direccioC == 3) {
        ypos = ypos + xspeed;

        if (ypos >= height) {
          ypos = 0;
        }
      }
    }
  }
}

static class Carretera {

  color c;
  int xpos;
  int ypos;
  int direccioC;

  Carretera(color tempC, int tempXpos, int tempYpos, int direccio) {    
    c = tempC;   
    xpos = tempXpos;   
    ypos = tempYpos;   
    direccioC = direccio;
  }

  void display() {
    noStroke();
    fill(c);
    if (direccioC == 2) {
      rect(xpos, ypos, width, 80);
    } else {
      if (direccioC == 3) {
        rect(xpos, ypos, 80, width);
      }
    }
  }
}

void keyPressed() {

  //Guarda una screenshot.
  if (key == 'c' || key == 'C') {
    saveFrame("output-####.png");
  }
  if (key == '+') {
    myCar.xspeed++;
  }
  if (key == '-') {
    myCar.xspeed--;
  }
  if (key == 't' || key == 'T') {
    if (debugactiu == true) {
      debugactiu = false;
    } else {
      debugactiu = true;
    }
  }
}

