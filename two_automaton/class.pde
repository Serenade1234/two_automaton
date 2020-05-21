class Game_of_life_and_rule_30{
    
    
    int state;
    int swap;
    int idi, idj;

    int gol_percentage = 45;
    int gol_height;

    color c1 = color(235, 230, 232);
    color c2_1 = color(233, 84, 113);
    //color c2_1 = color(200, 32, 100, 180);
    color c2_2 = color(28, 104, 174, 80);
    //color c2_2 = color(80, 60, 180, 80);
    color c3_1 = color(210, 237, 227, 30);
    //color c3_1 = color(140, 190, 240, 30);
    color c3_2 = color(82, 82, 111, 10);
    color c4 = color(50, 50, 50);

    int die_in = -1;
    int gens_to_die = 15;
    int last_after_death = 40;
    Boolean oneceLive = false;


    Game_of_life_and_rule_30(int i, int j){
        
        //state = int(random(2));
        if(i == int(num_w/2)-1 && j==num_h-1){
            state = 1;
        }else{
            state = 0;
        }

        idi = i;
        idj = j;

        gol_height = int(num_h*gol_percentage/100.0);

    }

    void update(){
        int i,j;

        if(idj < gol_height){
            int sum = 0;
            int im1, ip1, jm1, jp1;

            ip1 = (idi+1) % num_w; 
            if(idi==0) im1 = num_w-1;
            else       im1 = idi - 1;
            
            jp1 = (idj+1) % num_h;
            if(idj != 0){
                jm1 = idj-1;
                sum += g_state[im1][jm1].state;
                sum += g_state[idi][jm1].state;
                sum += g_state[ip1][jm1].state;
            }
            sum += g_state[im1][idj].state;
            sum += g_state[im1][jp1].state;
            
            sum += g_state[idi][jp1].state;
            
            sum += g_state[ip1][idj].state;
            sum += g_state[ip1][jp1].state;

            if(state == 0 && sum == 3){
                swap = 1;
                die_in = gens_to_die;
                oneceLive = true;
            }else if(state == 1 && (sum == 2 || sum == 3)){
                swap = state;
                die_in = gens_to_die;
                oneceLive = true;
            }else{
                swap = 0;
                die_in -= 1;
            }
        }else{

            if(idj < num_h-1){
                swap = g_state[idi][idj+1].state;
                if(swap == 1){
                    oneceLive = true;
                    die_in = gens_to_die;
                }else{
                    die_in-=1;
                }
            }else{
                int neigh_code;
                if(idi !=0) neigh_code = 4*g_state[idi-1][idj].state + 2*g_state[idi][idj].state + g_state[(idi+1)%num_w][idj].state;
                else        neigh_code = 4*g_state[num_w-1][idj].state + 2*g_state[idi][idj].state + g_state[(idi+1)%num_w][idj].state;
                if((RULE >> neigh_code)%2 == 1){
                    swap = 1;
                    oneceLive = true;
                    die_in = gens_to_die;
                }else{
                    swap = 0;
                    die_in-=1;
                }
            }
        }
    }

    void commit(){
        state = swap;
    }

    void show_self(float cell_w){
        if(g_colorful){

            if(state == 1){
                fill(c1);
                if(g_show_live)rect(idi*cell_w, idj*cell_w, cell_w, cell_w);

            }else if(die_in > 0 ){
                if(die_in > gens_to_die/2){
                    fill(c2_1);
                }else{
                    fill(c2_2);
                }
                rect(idi*cell_w, idj*cell_w, cell_w, cell_w);

            }else if(oneceLive){
                if(die_in > -last_after_death){
                    fill(c3_1);
                }else{
                    fill(c3_2);
                }
                rect(idi*cell_w, idj*cell_w, cell_w, cell_w);

            }else{
                fill(c4);
                rect(idi*cell_w, idj*cell_w, cell_w, cell_w);
            }

        }else{
            if(state == 1){
                fill(c1);
            }else{
                fill(c4);
            }
            rect(idi*cell_w, idj*cell_w, cell_w, cell_w);
        }
        //rect(idi*cell_w, idj*cell_w, cell_w, cell_w);
    }

}