/**********************************************************************************************
**author: Andre Christian                                                                    **
**********************************************************************************************/

public class Paddle {
    final private int paddle_height = 15;
    final private int radius = 20;
    private int paddle_width, x_pos, y_pos;
    
    /**
    *@param: none
    *@pre: the window must be set
    *@post: creates a paddle object
    */
    public Paddle() {
        paddle_width = (int) (0.2 * width);
        x_pos = width/2 - paddle_width/2;      //set initial x position to the middle
        y_pos = height - paddle_height;
    }

    public int get_left_pos() { return x_pos; }
    
    public int get_top_pos() { return y_pos; }
    
    public int get_right_pos() { return x_pos + paddle_width; }
    
    public int get_bot_pos() { return y_pos + paddle_height; }
    
    public int get_mid_pos() { return (int) (x_pos + paddle_width/2); }
    
    /**
    *@param: integers cursor_x that signifies the current x position of the cursor
    *@pre: none
    *@post: changes the x position of the paddle to follow the cursor
    */
    public void set_x(int cursor_x) {
      if (cursor_x + paddle_width/2 <= width && cursor_x - paddle_width/2 >= 0)
          x_pos = cursor_x - paddle_width/2;
    }
    
    /**
    *@param: none
    *@pre: none
    *@post: draws the paddle on the screen
    */
    public void draw() {
      fill(0);
      rect(x_pos, y_pos, paddle_width, paddle_height, radius);
    }
}