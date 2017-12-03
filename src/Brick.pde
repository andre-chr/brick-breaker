/**********************************************************************************************
**author: Andre Christian                                                                    **
**********************************************************************************************/

public class Brick {
   final private int radius = 20;
   final private color[] color_option = {color(0, 204, 102), color(255, 255, 102), color(255, 153, 51), color(230, 46, 0)};
   private int x_pos, y_pos, brick_width, brick_height, val;
   private color c;
   
   /**
   *@param: integers init_x_pos & init_y_pos to specify the location of the brick; integers init_brick_width & init_brick_height to specify the dimensions of the brick
   *@pre: none
   *@post: creates a brick object
   */
   public Brick(int init_x_pos, int init_y_pos, int init_brick_width, int init_brick_height) {
         x_pos = init_x_pos;
         y_pos = init_y_pos;
         brick_width = init_brick_width;
         brick_height = init_brick_height;
         val = (int) (Math.random() * 4) + 1;
         c = color_option[val-1];
   }
   
   public int get_left_pos() { return x_pos; }
   
   public int get_top_pos() { return y_pos; }
   
   public int get_right_pos() { return x_pos + brick_width; }
   
   public int get_bot_pos() { return y_pos + brick_height; }
   
   public int get_val() { return val; }
   
   public boolean is_within_x(int x) { return x >= get_left_pos() && x <= get_right_pos(); }
   
   public boolean is_within_y(int y) { return y >= get_top_pos() && y <= get_bot_pos(); }
   
    /**
    *@param: none
    *@pre: none
    *@post: draws the brick on the screen
    */
   public void draw() {
       fill(c);
       rect(x_pos, y_pos, brick_width, brick_height, radius);
   }
}