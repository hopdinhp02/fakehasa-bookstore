/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.DAO;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author This Pc
 */
public class Cart {
    private List<Item> items;
    
    public Cart(){
        items = new ArrayList<>();
    }
    
    public List<Item> getItems(){
        return items;
    }
    
    private Item getItemById(int id){
        for(Item i: items){
            if(i.getBook().getId()==id){
                return i;
            }
        }
        return null;
    }
    
    public int getQuantityById(int id){
        return getItemById(id).getQuantity();
    }
    
    public void addItem(Item t){
        if(getItemById(t.getBook().getId())!=null){
            Item m = getItemById(t.getBook().getId());
            m.setQuantity(m.getQuantity()+t.getQuantity());
        }else{
            items.add(t);
        }
    }
    
    public void removeItem(int id){
        if(getItemById(id)!=null){
            items.remove(getItemById(id));
        }
    }
    
    public double getTotalMoney(){
        double t = 0;
        for(Item i: items)
            t+=(i.getQuantity()*i.getPrice());
        return t;
    }
    private Book getBookById(int id, List<Book> list){
        for (Book b : list) {
            if(b.getId()==id){
                return b;
            }
        }
        return null;
    }
    
    public Cart(String txt, List<Book> list){
        items = new ArrayList<>();
        try{
            if(txt!=null && txt.length()!=0){
            String[] s = txt.split("/");
            for (String i : s) {
                String[] n = i.split(":");
                int id = Integer.parseInt(n[0]);
                int quantity = Integer.parseInt(n[1]);
                Book b = getBookById(id, list);
                Item t = new Item(b, quantity, b.getUnitPrice()*1.2);
                addItem(t);
            }
        }
        }catch(NumberFormatException e){
            System.out.println(e);
        }
        
    }
    
    private Book getBookById(int id){
        DAO d = new DAO();
        return d.getBookById(id);
    }
    public Cart(String txt){
        items = new ArrayList<>();
        try{
            if(txt!=null && txt.length()!=0){
            String[] s = txt.split("/");
            for (String i : s) {
                String[] n = i.split(":");
                int id = Integer.parseInt(n[0]);
                int quantity = Integer.parseInt(n[1]);
                Book b = getBookById(id);
                Item t = new Item(b, quantity, b.getUnitPrice()*1.2);
                addItem(t);
            }
        }
        }catch(NumberFormatException e){
            System.out.println(e);
        }
        
    }
    
}
