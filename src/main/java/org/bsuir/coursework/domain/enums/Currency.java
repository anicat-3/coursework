package org.bsuir.coursework.domain.enums;

public enum Currency {
    BYN, RUB, USD, EUR;
    public int getVal(){
        switch (this){
            case BYN -> {return 0;}
            case RUB -> {return 1;}
            case USD -> {return 2;}
            case EUR -> {return 3;}
        }
        return -1;
    }
}
