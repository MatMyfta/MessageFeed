/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

/**
 *
 * @author acer
 */
public class Message {

    public static int counter = 0;
    
    public enum SpecialString {GOAL,FAULT,PENALTY,END};
    public Integer nr;
    public String string;
    
    Message(String string) {
        this.nr = ++counter;
        this.string = string;
    }
    
    public SpecialString hasSpecialString () {
        if (this.string.contains("Goal")) return SpecialString.GOAL;
        else if (this.string.contains("Fault")) return SpecialString.FAULT;
        else if (this.string.contains("Penalty")) return SpecialString.PENALTY;
        else if (this.string.contains("END")) return SpecialString.END;
        return null;
    }
}
