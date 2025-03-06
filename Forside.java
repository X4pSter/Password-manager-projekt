import processing.core.*;
import java.util.ArrayList;

public class Forside{

    private PApplet p;

    private ArrayList<Knap> knap1 = new ArrayList<Knap>();
    private TekstFelt tekstFelt1;
    
    public Forside(PApplet p, Knap k1, TekstFelt t1){
        this.p = p;
        knap1.add(k1);
        tekstFelt1 = t1;
    }
}