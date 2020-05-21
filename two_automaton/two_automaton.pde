Game_of_life_and_rule_30[][] g_state;

int RULE = 30;
float cell_width = 3;
Boolean g_colorful = true, g_show_live = true;

int num_w;
int num_h;

void setup(){
    size(1600, 500);
    //fullScreen();
    noStroke();
    smooth();
    init();
}

void draw(){
    int i, j;
    for(i=0; i<num_w; i++){
        for(j=0; j<num_h; j++){
            g_state[i][j].update();
        }
    }

    for(i=0; i<num_w; i++){
        for(j=0; j<num_h; j++){
            g_state[i][j].commit();
            g_state[i][j].show_self(cell_width);
        }
    }

        //if(frameCount % 600 == 0) println(frameCount);
        //saveFrame("frames/#########.png");

}

void init(){
    int i,j;

    g_state = new Game_of_life_and_rule_30[width][height];
    num_w = int(width / cell_width);
    num_h = int(height / cell_width);

    for(i=0; i<num_w; i++){
        for(j=0; j<num_h; j++){
            g_state[i][j] = new Game_of_life_and_rule_30(i, j);
        }
    }
}

void keyPressed(){
    if(key == 's') saveFrame("printscreen/########.jpg");
    else if(key == '1') g_colorful = !g_colorful;
    else if(key == '2') g_show_live = !g_show_live;
    else{
        RULE = int(random(256));
        init();
    }
}