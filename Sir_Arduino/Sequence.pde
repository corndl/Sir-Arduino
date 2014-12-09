class Sequence{
  
  public IntList seq;
  
  public Sequence(IntList sequence){
    seq = sequence;
  }
  
  public int duree(){
    int res = 0;
    for(int i = 0;i<seq.size();i++){
      res += seq.get(i);
    }
    return res;
  } 
  
  public void play(InOutArduino ioa){
    ioa.turnOn(false);
  }
  //comparaison de 2 sequence.
  public int distance(Sequence s){
    int duree1 = this.duree();
    int duree2 = s.duree();
    
    int duree = min(duree1,duree2);
    int diff = abs(duree1-duree2);
    
    int res = 0;
    int iter1 = 0;
    int iter2 = 0;
    
    int sum1=0;
    int sum2=0;
    
    IntList s1 = new IntList(this.seq);
    IntList s2 = new IntList(s.seq);
    /*
    println(s1);
    println(s2);
    //*/
    for(int i = 0;i<duree;i++){
      
      int value1 = s1.get(iter1);
      int value2 = s2.get(iter2);
      if(sum1+value1<i){
        sum1+=value1;
        iter1++;
        value1 = s1.get(iter1);
        //println("1 : "+iter1 + " line: "+i);
      }
      if(sum2+value2<i){
        sum2+=value2;
        iter2++;
        value2 = s2.get(iter2);
        //println("2 : "+iter2 + " line: "+i);
      }
      if(iter1%2!=iter2%2)res++;
    }
    
    res+=diff;
    return res;
    
    /*
    int diff= 0;
    IntList seq1 = this.seq;
    IntList seq2 = s.seq;
    
    if(seq1.size()==0) {
      for(int i =0;i<seq2.size();i++){
        diff =+ seq2.get(i);
      }
      return diff;
    }
    if (seq2.size() == 0){
      for(int i=0;i<seq1.size();i++){
        diff =+ seq1.get(i);
      }
      return diff;
    }
    
    if(seq1.get(0)>=seq2.get(0)){
      seq1 = new IntList(seq1);
      seq2 = new IntList(seq2);
    }else{
      IntList seqTemp = new IntList(seq2);
      seq2 = new IntList(seq1);
      seq1 = seqTemp;
    }
    
    println(seq1);
    println(seq2);
    
    int duree1 = seq1.remove(0);
    int duree2 = seq2.remove(0);
    
    if(duree1==duree2){
      println("duree égale : " + duree1 + " == " + duree2); 
      Sequence sq1 = new Sequence(seq1);
      Sequence sq2 = new Sequence(seq2);
      return sq1.distance(sq2);
    }else{
      int att = duree1 - duree2;
      diff =+ seq2.remove(0);
      println("duree différente : " + duree1 + " - " + duree2 + " = "+att+ " diff = "+diff);
      if(att > diff){
        seq2.add(0,att-diff);
        
        Sequence sq1 = new Sequence(seq1);
        Sequence sq2 = new Sequence(seq2);
        return diff + sq1.distance(sq2);
      }else{
        seq1.add(0,diff-att);
        Sequence sq1 = new Sequence(seq1);
        Sequence sq2 = new Sequence(seq2);
        return sq1.distance(sq2);
      }
    }
    //*/
  }
  
  
}
