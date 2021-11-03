
public class ObjetoSolido{
    int x;
    int y;
    int ancho;
    public int alto;
    float mitadDelAlto;
    float mitadDelAncho;
}

public boolean hayColisionCuadradoCuadrado(ObjetoSolido obj1, ObjetoSolido obj2) {
    //Si esta tocando en x
    if (!(
        obj1.x > obj2.x + obj2.ancho || 
        obj1.x + obj1.ancho < obj2.x 
       )) {
        
        int objeto1ParteDeAbajo = obj1.y + obj1.alto;
        int objeto2ParteDeAbajo = obj2.y + obj2.alto;
        circle(900,objeto2ParteDeAbajo,10);
        
        boolean elObjeto1EstaTocandoAElObjeto2PorArriba = objeto1ParteDeAbajo > obj2.y && objeto1ParteDeAbajo < objeto2ParteDeAbajo;
        
        boolean elObjeto1EstaTocandoAElObjeto2PorAbajo = obj1.y < objeto2ParteDeAbajo && obj1.y > obj2.y;
        
        
        //Y esta tocando en y
        if (elObjeto1EstaTocandoAElObjeto2PorAbajo || elObjeto1EstaTocandoAElObjeto2PorArriba) {
            return true;
        }
    }
    return false;
}

public boolean estanTocandoseEnX(ObjetoSolido obj1, ObjetoSolido obj2) {
    //Si esta tocando en x
    if (!(
        obj1.x > obj2.x + obj2.ancho || 
        obj1.x + obj1.ancho < obj2.x 
       )) {
        return true;
    }
    return false;
}




import java.util.*;

public class Ladrillo extends ObjetoSolido{
    int yparteabajo;
    int xderecha;
    PImage LadrilloImg;
    public Ladrillo(int x, int y) {
        this.x = x;
        this.y = y;
        this.ancho = 100;
        this.alto = 100;
        this.yparteabajo = y + alto;
        this.xderecha = x + ancho;
        this.LadrilloImg = loadImage("Ladrillo.jpg");
        this.DibujarLadrillo();
        this.mitadDelAncho = this.ancho / 2;
        this.mitadDelAlto = this.alto / 2;
    }
    public void DibujarLadrillo() {
        image(this.LadrilloImg,this.x, this.y ,this.ancho,this.alto);
    }
}

/*
String jugadorLadrilloColision(Yoshi jugador, Ladrillo ladrillo) {

if (hayColisionCuadradoCuadrado(jugador, ladrillo)) { 
boolean seTocanEnY = true;

int jugadorParteDeAbajo = jugador.y + jugador.alto;
int ladrilloParteDeAbajo = ladrillo.y + ladrillo.alto;

int centroLadrilloEnY = ladrillo.y + (ladrillo.alto / 2);
int largoLadrillo = 50;
int centroLadrilloEnX = ladrillo.x + largoLadrillo;

//Me fijo la parte izquierda de x
if (jugador1.derechaYoshi + 10 > ) {
return "derecha";
}


    }
return "nohay";
}
*/

public class Yoshi  extends ObjetoSolido {
    
    // Personaje
    float derechaYoshi;
    int direccionX;
    float lastDirection;
    float normalizacion;
    float distanciaTotalSimetria;
    PImage yoshiImg;
    float velocidadY;
    int velocidadX = 5;
    float aceleracionY;
    boolean estaSaltando;
    String ladoDeColision;
    int basePiso;
    boolean estaEnElPiso;
    int parteDeAbajoYoshi;
    
    public Yoshi(int x, int y) {
        this.x = x;
        this.y = y;
        this.derechaYoshi = this.x + this.ancho;
        this.direccionX = 0;
        this.lastDirection = 0;
        this.velocidadY = 0;
        this.velocidadX = 5;
        this.ladoDeColision = "";
        this.aceleracionY = 0.8;
        this.yoshiImg = loadImage("yoshi.png");
        this.alto = 150;
        this.parteDeAbajoYoshi = this.y + 150;
        this.ancho = (this.yoshiImg.width) / 2;
        this.mitadDelAncho = this.ancho / 2;
        this.mitadDelAlto = this.alto / 2;
        this.estaSaltando = false;
        this.estaEnElPiso = true;
        this.basePiso = 200;
    }
    
    public void moverYoshi(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public void setDireccion(int direccion) {
        this.lastDirection = this.direccionX;
        this.direccionX = direccion;
    }
    
    public void saltar() {
        if (this.estaEnElPiso) {
            this.velocidadY = -20;
            this.estaSaltando = true;
            this.estaEnElPiso = false;
        }
    }
    
    void DibujarYoshi() {
        pushMatrix();
        if (this.direccionX == -1 || (this.lastDirection == -1 && this.direccionX == 0)) {
            translate(this.x + (this.yoshiImg.width) / 2, this.y);
            scale( -1,1);
            image(this.yoshiImg,0,0,130,150);
        }
        else{
            image(this.yoshiImg,this.x, this.y ,130,150);
        }
        
        popMatrix();
        circle(this.x, this.y, 10);
        circle(this.ancho + this.x, this.y, 10);
        circle(this.x, this.parteDeAbajoYoshi, 10);
    }
    
    public void actualizarYoshi() {
        this.x = constrain(this.x, 0, displayWidth);
        this.x = this.x + this.direccionX * this.velocidadX;
        this.derechaYoshi = this.x + this.ancho;
        this.parteDeAbajoYoshi = this.y + 150;
        
        if (this.y > this.basePiso) {
            this.estaSaltando = false;
            this.estaEnElPiso = true;
            this.y = this.basePiso;
        }
        
        this.y += this.velocidadY;
        
        if (this.estaSaltando) {
            this.velocidadY += this.aceleracionY;
        }
        
    }
    
    void actualizarEstadoSegunPlataforma() {
        if (this.ladoDeColision == "abajo" && this.velocidadY >= 0) {
            if (this.velocidadY < 1) {
                this.estaEnElPiso = true;
                this.velocidadY = 0;
            }
        } else if (this.ladoDeColision == "arriba" && this.velocidadY <=  0) {
            this.velocidadY = 0;
        } else if (this.ladoDeColision == "derecha" && this.velocidadX >=  0) {
            this.velocidadX = 0;
        } else if (this.ladoDeColision == "izquierda" && this.velocidadX <= 0) {
            this.velocidadX = 0;
        }
        if (this.ladoDeColision != "abajo" && this.velocidadY > 0) {
            this.estaEnElPiso = false;
        }
        
        if (this.y == this.basePiso) {
            this.estaSaltando = false;
            this.estaEnElPiso = true;
        }
        
    }
    
}

// Teclas
boolean leftPressed = false;
boolean rightPressed = false;
boolean upPressed = false;
boolean enterPressed = false;
// Escenario
int   alturaPiso; // ¿Donde esta el piso ? 
List<Ladrillo> ladrillos;
int cafe = 0;
int reloj = 3;
int libro = 0;
// Estados
Yoshi jugador1;

int baseYoshi;

void setup() {
    fullScreen();
    alturaPiso = displayHeight - 220;
    jugador1 = new Yoshi(150, alturaPiso);
    baseYoshi = alturaPiso - (jugador1.alto / 2);
    jugador1.moverYoshi(250, baseYoshi);
    jugador1.basePiso = baseYoshi;
    CrearLadrillos();
    jugador1.DibujarYoshi();
}

//displayWidth
void draw() {
    if (FinDelJuego(reloj)) {
        DibujarFinal();
        if (enterPressed) {
            reloj = 3;
        }
        
    } else{
        background(#ABE0FC);
        DibujarEje();
        DibujarPiso();
        DibujarNubes();
        DibujarDatos(reloj,libro,cafe);
        DibujarLadrillos();
        
        if (upPressed) {
            jugador1.saltar();
        }
        int xd = 0;
        jugador1.actualizarYoshi();
        for (Ladrillo ladrillo : ladrillos) {
            //jugador1.ladoDeColision = jugadorLadrilloColision(jugador1, ladrillo);
            text(jugador1.ladoDeColision,500 ,100 + xd);
            xd = xd + 300;
            //jugador1.actualizarEstadoSegunPlataforma();
        }
        jugador1.DibujarYoshi();
        DibujarEje();
    }
}

boolean FinDelJuego(int reloj) {
    return reloj == 0;
}


void keyPressed() {
    if (keyCode == ENTER) {
        enterPressed = true;
    }
    if (keyCode == LEFT) {
        jugador1.setDireccion( -1);
        leftPressed = true;
        
    } else if (keyCode == RIGHT) {
        jugador1.setDireccion(1);
        rightPressed = true;
    }
    
    if (keyCode == UP) {
        upPressed = true;
    }
}

void keyReleased() {
    if (keyCode == LEFT) {
        leftPressed = false;
    }
    if (keyCode == ENTER) {
        enterPressed = false;
    }
    
    if (keyCode ==  RIGHT) {
        rightPressed = false;
    }
    
    if (!(leftPressed || rightPressed)) {
        jugador1.setDireccion(0);
    }
    
    if (keyCode == UP) {
        upPressed = false;
    }
}

void DibujarLadrillos() {
    pushMatrix();
    for (Ladrillo ladrillo : ladrillos) {
        ladrillo.DibujarLadrillo();
    }
    popMatrix();
}

void CrearLadrillos() {
    ladrillos = new ArrayList<Ladrillo>();
    for (int i = 0; i <=  2; i++) {
        ladrillos.add(new Ladrillo(i * 100,560));
    }
    ladrillos.add(new Ladrillo(500,800));
    ladrillos.add(new Ladrillo(0,800));
}

void DibujarNubes() {
    pushMatrix();
    fill(255,255,255);//blanco
    noStroke();
    for (int i = 1; i < 5; i++) {
        translate(0,100);
        ellipse(170,150,250,110);
        ellipse(200,150,100,150);
        translate( -10,0);
        ellipse(150,150,100,150);
        translate(770,0);
    }
    popMatrix();
}

void DibujarCafe() {
    pushMatrix();//2
    translate(125, -43);
    scale(0.2,0.2);
    fill(255);
    noStroke();
    rect(326,420,200,220);
    stroke(0);
    scale(4,4);
    translate(50,50);
    strokeWeight(3);
    arc(80,85,25,25,radians(270),radians(450),OPEN);
    fill(#90471C);
    ellipse(55,55,50,10);
    fill(255);
    line(30,55,30,110);
    line(80,55,80,110);
    arc(55,110,50,10,radians(0),radians(180),OPEN);
    pushMatrix();//1
    translate(40,10);
    fill(#ABE0FC);
    arc(0,20,10,20,radians(260),radians(450),OPEN);
    arc(0,0,10,20,radians(90),radians(280),OPEN);
    popMatrix();//1
    translate(60,10);
    arc(0,20,10,20,radians(260),radians(450),OPEN);
    arc(0,0,10,20,radians(90),radians(280),OPEN);
    fill(0);
    textSize(10);
    text("BEST", -20,72);
    text("FINGER", -23,85);
    popMatrix();//2
}

void Dibujarlibro() {
    pushMatrix();
    scale(0.3,0.3);
    translate(50,0);
    stroke(0);
    fill(#4228AD);//azul
    strokeWeight(7);
    rect(100,100,150,200);
    quad(100,300,50,270,50,80,100,100);
    strokeWeight(3);
    fill(255,255,255);// blanco
    quad(100,100,50,80,200,80,250,100);
    fill(#2D76D3);//celeste
    quad(50,110,100,130,100,160,50,140);
    translate(0,100);
    quad(50,110,100,130,100,160,50,140);
    translate(0, -100);
    rect(120,120,110,160);
    fill(#4228AD);//azul
    noStroke();
    ellipse(120,120,30,30);
    ellipse(230,120,30,30);
    ellipse(120,280,30,30);
    ellipse(230,280,30,30);
    stroke(0);
    arc(120,120,30,30,radians(0),radians(90),OPEN);
    arc(230,120,30,30,radians(90),radians(180),OPEN);
    arc(120,280,30,30,radians(270),radians(360),OPEN);
    arc(230,280,30,30,radians(180),radians(270),OPEN);
    fill(0);
    textSize(150);
    PFont f = createFont("Serif",160);
    textFont(f); 
    text("F", 135,250);
    popMatrix();
}

void DibujarReloj() {
    pushMatrix();
    translate(300, -25);
    scale(0.4,0.4);
    fill(#FA7223);
    strokeWeight(5);
    ellipse(200,200,200,200);
    line(105,200,130,200);
    line(270,200,295,200);
    line(200,105,200,130);
    line(200,295,200,270);
    fill(255);
    strokeWeight(2);
    ellipse(200,200,10,10);
    arc(165,210,30,150,radians(180),radians(360),CLOSE);
    arc(230,210,30,150,radians(180),radians(360),CLOSE);
    arc(200,230,80,40,radians(0),radians(180),CLOSE);
    fill(0);
    ellipse(165,180,15,50);
    ellipse(230,180,15,50);
    arc(244.5,227,10,10,radians(70),radians(175),OPEN);
    arc(158,227,10,10,radians(340),radians(445),OPEN);
    fill(255);
    noStroke();
    triangle(168,175,170,160,175,162);
    triangle(233,175,235,160,240,162);
    popMatrix();
}

void DibujarDatos(int reloj, int libro, int cafe) {
    Dibujarlibro();
    textSize(10);
    PFont f = createFont("Serif",50);
    textFont(f); 
    text("x",102,75);
    text(libro,135,75);
    DibujarCafe();
    pushMatrix();
    textFont(f);
    translate(150,0);
    text("x",102,75);
    text(cafe,135,75);
    popMatrix();
    DibujarReloj();
    pushMatrix();
    fill(0);
    textFont(f);
    translate(330,0);
    text("x",102,75);
    text(reloj,135,75);
    popMatrix();
}

void DibujarFinal() {
    pushMatrix();
    background(0);
    fill(255,0,0);
    PFont f = createFont("Serif",50);
    textFont(f); 
    translate( -175,0);
    text("FIN DEL JUEGO", displayWidth / 2,displayHeight / 2);
    translate( -75,0);
    text("toque enter para reiniciar",displayWidth / 2, displayHeight / 2 + 100);
    popMatrix();
}

void DibujarEje() {
    pushMatrix();
    color(255, 0, 0);
    for (int y = 0; y < displayWidth; y += 100) {
        for (int x = 0; x < displayWidth; x += 100) {
            stroke(255);
            point(x, y);
            String punto = String.format("( % d, % d)",x,y);
            textSize(15);
            text(punto, x + 2, y + 2); 
        }
    }
    popMatrix();
}

void DibujarPiso() {
    pushMatrix();
    fill(198,66,14);// marron
    strokeWeight(6);
    stroke(0);
    rect(0,displayHeight - 150,displayHeight,displayHeight);//piso
    for (int x = 1; x <=  19; x = x + 1) {
        rect(0,displayHeight - 150,120,300);//
        line(100,displayHeight - 150,100,displayHeight);//linea vertical piso
        rect(75,displayHeight - 150,25,25);//ladrillos
        quad(75,displayHeight - 130,50,displayHeight - 5,0,displayHeight - 80,0,displayHeight - 155);//ladrillos
        translate(100,0);
    }
    popMatrix();
}
