/**********************************************************************************************
**author: Andre Christian                                                                    **
**********************************************************************************************/

final double VELOCITY_CONSTANT = 0.007;

public class Ball {
    final color BALL_COLOR = color(255, 0, 0);
    private int radius, x_pos, y_pos, x_velocity, y_velocity;
    private boolean play = true;
    
    /**
    *@param: radius of the ball
    *@pre: none
    *@post: creates a ball object
    */
    public Ball(int init_radius) {
        x_pos = width;
        y_pos = height;
        x_velocity = (int) (width * VELOCITY_CONSTANT);
        y_velocity = (int) (height * VELOCITY_CONSTANT);
        radius = init_radius;
    }
    
    /**
    *@param: none
    *@pre: the ball must be in play
    *@post: removes the ball from the game
    */
    public void destroy_ball() {
        play = false;
    }
    
    /**
    *@param: none
    *@pre: none
    *@post: resets the direction of the ball (to 45 degrees to the right)
    */
    public void reset_velocity() {
        x_velocity = abs(x_velocity);
        y_velocity = abs(y_velocity);
    }
    
    public int get_x() { return x_pos; }
    
    public int get_y() { return y_pos; }
    
    /**
    *@param: none
    *@pre: none
    *@post: draws the ball on the screen
    */
    public void draw() {
        if (play) {
            fill(BALL_COLOR);
            ellipse(x_pos, y_pos, radius*2, radius*2);
        }
    }
    
    /**
    *@param: a paddle object
    *@pre: none
    *@post: moves the ball based on the current velocity and checks if the ball is colliding with the paddle
    */
    public void move(Paddle p) {
        if (play) {
            x_pos += x_velocity;
            y_pos += y_velocity;
            
            //check if out of bounds
            if (x_pos - radius <= 0 || x_pos + radius >= width) {
                x_velocity *= -1;
            }
            if (y_pos - radius <= 0) {
                y_velocity *= -1; 
            }
            paddle_collision(p);
         }
     }
     
     /**
     *@param: a paddle object
     *@pre: none
     *@post: sets the ball in the middle of the paddle
     */
     public void still(Paddle p) {
         x_pos = p.get_mid_pos();
         y_pos = p.get_top_pos() - radius;
     }
     
     /**
     *@param: none
     *@pre: the ball must be in play (play = true)
     *@post: returns true if the did fell off the screen, else returns false
     */
     public boolean is_gone() {
         return y_pos > height;  
     }
    
    /**
    *@param: a paddle object, p
    *@pre: none
    *@post: bounces the ball upwards if it comes in contact with the paddle
    */
    public void paddle_collision(Paddle p) {
        if (play) {
           if (y_velocity > 0 && y_pos + radius >= p.get_top_pos() && x_pos >= p.get_left_pos() && x_pos <= p.get_right_pos()) {
               y_velocity *= -1;
           }
        }
    }
    
    /**
    *@param: a brick object, b 
    *@pre: none
    *@post: bounces the ball if it comes in contact with the brick and returns true, else return false
    */
    public boolean brick_collision(Brick b) {
         boolean res = false;
         if (play) {
             if ( ((y_pos + radius) >= b.get_top_pos() && x_pos >= b.get_left_pos() && x_pos <= b.get_right_pos()) && 
                   ((y_pos - radius) <= b.get_bot_pos() && x_pos >= b.get_left_pos() && x_pos <= b.get_right_pos()) ) {
                 y_velocity *= -1;
                 res = true;
             }
             if ( ((x_pos + radius) >= b.get_left_pos() && b.is_within_y(y_pos)) && 
                   ((x_pos - radius) <= b.get_right_pos() &&  b.is_within_x(x_pos))) {
                 x_velocity *= -1;
                 res = true;
             }
             
         }
         return res;
    }
}