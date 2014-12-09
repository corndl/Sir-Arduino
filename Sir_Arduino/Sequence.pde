class Sequence{
  
  public IntList seq;
  
  public Sequence(IntList sequence){
    seq = sequence;
  }
  //comparaison de 2 sequence.
  public int smartEquals(Sequence s){
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
      seq1 = new IntList(seq2);
      seq2 = new IntList(seq1);
    }
    
    int duree1 = seq1.remove(0);
    int duree2 = seq2.remove(0);
    
    if(duree1==duree2){
      Sequence sq1 = new Sequence(seq1);
      Sequence sq2 = new Sequence(seq2);
      return sq1.smartEquals(sq2);
    }else{
      int att = duree1 - duree2;
      diff =+ seq2.remove(0);
      if(att > diff){
        seq1.add(0,att-diff);
        Sequence sq1 = new Sequence(seq1);
        Sequence sq2 = new Sequence(seq2);
        return diff + sq1.smartEquals(sq2);
      }else{
        seq2.add(0,diff-att);
        Sequence sq1 = new Sequence(seq1);
        Sequence sq2 = new Sequence(seq2);
        return sq1.smartEquals(sq2);
      }
    }
  }
  
  
}
