
int start() {
 
   double dlbLot = 1;
   int intMaxOrders = 3;
   
   int ticket;
   int ticketDell;
   bool haveThisSymbol = false;
   int intCurrentOrder = 0;
   
   int numRand = 1 + 10*MathRand()/32768; // 1-10
   
   //comment on chart
   Comment( 
            "\nnumRand: " + DoubleToStr(numRand, 0)
          );
          
    
    // /*open orders
    if (OrdersTotal() < intMaxOrders) {
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      if ( (numRand < 5) ) { // sell
         if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red);}
         Sleep(60000*30); //30 min
      }   
      if ( (numRand > 5) ) { // buy
         if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green);}
         Sleep(60000*30); //30 min
      }     
      
    }
  
  //*/
             
            
   return(0);
  }