int start() {
 
   int intMaxOrders = 4;
   double dlbLot = 0.2;
   
   int intCurrentOrder;
   int ticket;
   bool haveThisSymbol = false;
   
   int numRand = MathRand()%3 + -1;  //-1, 0, 1
   

   //comment on chart
   Comment( 
            "\nnumRand: " + DoubleToStr(numRand, 0)
          );
    
   
    //*open orders
   if (OrdersTotal() < intMaxOrders) {
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      if (numRand = -1) {  // sell 
         if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }
      if (numRand = 1) {  // buy
         if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
         
      } 
      

   
   return(0);
}
