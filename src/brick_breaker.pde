/**********************************************************************************************
**author: Andre Christian                                                                    **
**********************************************************************************************/

final int MIN_ROWS = 3;
final int MAX_ROWS = 6;
final int COL = 5;
final double WINDOW_BRICK_GAP = 0.1;
final double VERTICAL_GAP = 0.5;
final double BRICK_X_GAP = 0.04;
final double BRICK_Y_GAP = 0.02;


Paddle the_paddle;
Ball the_ball;
ArrayList<Brick> bricks;
boolean start_flag = false;
int score, life;

void setup() {
   size(1080, 760);
   background(255);
   textSize(25);
   smooth();
   the_paddle = new Paddle();
   the_ball = new Ball(8);
   bricks = generate_bricks();
   score = 0;
   life = 5;
   start_flag = true;
}

void draw() {
   background(255);
   the_paddle.set_x(mouseX);
   if (start_flag) {
       the_ball.still(the_paddle);
   } else {
       the_ball.move(the_paddle);    //moves the ball according to current velocity
       //checks for collision for each brick
       for (int i=0; i < bricks.size(); i++) {
            Brick b = bricks.get(i);
            if (the_ball.brick_collision(b)) {
                   score += b.get_val();
                   bricks.remove(i);      //delete the brick from the arraylist so it's not drawn again
                   break;
             }
        }
        
        //if the ball falls below
        if (the_ball.is_gone()) {
            if (life > 0) {
                   life -= 1;
                   start_flag = true;
            } else {
                   game_over("GAME OVER");
            }
        }
   }

   if (bricks.isEmpty())
       game_over("YOU WIN");

   //draw game elements
   for (Brick b:bricks) {
       if (b != null) {
           b.draw();
       }
   }
   the_paddle.draw();
   the_ball.draw();
   draw_text();
}

/**
*@param: none
*@pre: none
*@post: draws the current score and number of lives left on the screen
*/
void draw_text() {
    textAlign(LEFT);
    fill(0);
    text("Current score: " + score, 0.01 * width, 0.05 * height);
    text("Life: " + str(life), 0.9 * width, 0.05 * height); 
}

void game_over(String message) {
    the_ball.destroy_ball();
    textAlign(CENTER);
    fill(0);
    text(message, width/2, height/2);  
}

/**
*@param: mouse click
*@pre: none
*@post: launches the ball from the paddle when the mouse is clicked
*/
void mousePressed() {
    if (start_flag) {
        the_ball.reset_velocity();
        start_flag = false;
    }
}

/**
*@param: none
*@pre: none
*@post: generate bricks based on the window
*/  
public ArrayList<Brick> generate_bricks() {
    int window_space = (int) (WINDOW_BRICK_GAP * width);
    int vert_space = (int) (VERTICAL_GAP * height);
    int brick_x_space = (int) (BRICK_X_GAP * width);
    int brick_y_space = (int) (BRICK_Y_GAP * height);
    int brick_width = (int) ((width - 2 * window_space) / COL - brick_x_space);
    int brick_height = (int) ((height - window_space - vert_space) / MAX_ROWS - brick_y_space);
    
    ArrayList<Brick> brick_list = new ArrayList<Brick>();
    
    for (int j=window_space + brick_x_space/2; j < window_space + COL * (brick_x_space + brick_width); j += brick_width + brick_x_space) {
          int rand_row = (int) random(MIN_ROWS, MAX_ROWS+1);   //(int) (Math.random() * (MAX_ROWS-MIN_ROWS+1)) + MIN_ROWS;
          for (int i=window_space; i < window_space + rand_row * (brick_y_space+brick_height); i += brick_height + brick_y_space) {
               brick_list.add(new Brick(j, i, brick_width, brick_height));
               rect(i, j, 10, 10);
          }
    }
    return brick_list;
}