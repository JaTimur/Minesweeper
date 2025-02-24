import de.bezier.guido.*;
public final static int NUM_ROWS=25;
public final static int NUM_COLS=25;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines=new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons=new MSButton[NUM_ROWS][NUM_COLS];
    for(int n=0;n<NUM_ROWS;n++){
      for(int m=0;m<NUM_COLS;m++){
        buttons[n][m]=new MSButton(n,m);
      }
    }
    for(int n=0;n<150;n++){setMines();}
}
public void setMines()
{
    int row=(int)(Math.random()*NUM_ROWS);
    int col=(int)(Math.random()*NUM_COLS);
    if(mines.contains(buttons[row][col])){}
    else mines.add(buttons[row][col]);
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    int trues=0;
    for(int n=0;n<mines.size();n++){if(mines.get(n).isFlagged()) trues++;}
    return(trues==mines.size());
}
public void displayLosingMessage()
{
    buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("L");
    buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("S");
    buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("E");
}
public void displayWinningMessage()
{
    buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("W");
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("I");
    buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("N");
}
public boolean isValid(int r, int c)
{
    return((r<NUM_ROWS&&r>=0)&&(c<NUM_COLS&&c>=0));
}
public int countMines(int row, int col)
{
  int numMines = 0;
  if(isValid(row+1,col)){if(mines.contains(buttons[row+1][col])) numMines++;}
  if(isValid(row-1,col)){if(mines.contains(buttons[row-1][col])) numMines++;}
  if(isValid(row,col+1)){if(mines.contains(buttons[row][col+1])) numMines++;}
  if(isValid(row,col-1)){if(mines.contains(buttons[row][col-1])) numMines++;}
  if(isValid(row+1,col+1)){if(mines.contains(buttons[row+1][col+1])) numMines++;}
  if(isValid(row+1,col-1)){if(mines.contains(buttons[row+1][col-1])) numMines++;}
  if(isValid(row-1,col+1)){if(mines.contains(buttons[row-1][col+1])) numMines++;}
  if(isValid(row-1,col-1)){if(mines.contains(buttons[row-1][col-1])) numMines++;}
  return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton==RIGHT){
          if(flagged){
            flagged=false;
            clicked=false;
          }
          else flagged=true;
        }
        else if(mines.contains(this)) displayLosingMessage();
        else if(countMines(myRow,myCol)>0) setLabel(countMines(myRow,myCol));
        else{
          if(isValid(myRow-1,myCol)&&!buttons[myRow-1][myCol].clicked) buttons[myRow-1][myCol].mousePressed();
          if(isValid(myRow+1,myCol)&&!buttons[myRow+1][myCol].clicked) buttons[myRow+1][myCol].mousePressed();
          if(isValid(myRow,myCol-1)&&!buttons[myRow][myCol-1].clicked) buttons[myRow][myCol-1].mousePressed();
          if(isValid(myRow,myCol+1)&&!buttons[myRow][myCol+1].clicked) buttons[myRow][myCol+1].mousePressed();
          if(isValid(myRow-1,myCol-1)&&!buttons[myRow-1][myCol-1].clicked) buttons[myRow-1][myCol-1].mousePressed();
          if(isValid(myRow-1,myCol+1)&&!buttons[myRow-1][myCol+1].clicked) buttons[myRow-1][myCol+1].mousePressed();
          if(isValid(myRow+1,myCol-1)&&!buttons[myRow+1][myCol-1].clicked) buttons[myRow+1][myCol-1].mousePressed();
          if(isValid(myRow+1,myCol+1)&&!buttons[myRow+1][myCol+1].clicked) buttons[myRow+1][myCol+1].mousePressed();
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
