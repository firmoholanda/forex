int start() {
 
   int intMaxOrders = 4;
   double dlbLot = 0.1;
   
   int intCurrentOrder;
   int ticket;
   bool haveThisSymbol = false;
   
   int numRand = 0 + 10*MathRand()/32768; // 0-10   

   //comment on chart
   //Comment( 
   //         "\nnumRand: " + DoubleToStr(numRand, 0) +
   //         "\nOrderProfit: " + DoubleToStr(OrderProfit(), 2)
   //       );
  
  
   // retrieving info from trade history
   int i,hstTotal=OrdersHistoryTotal();
   for(i=0;i<hstTotal;i++) {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false) {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
      }
     // some work with order
     if (OrderSymbol() == Symbol()) {  //get current symbol on graph
        Comment( 
               "\nOrderProfit: " + DoubleToStr(OrderProfit(), 2) +
               "\nOrderType(): " + OrderType()  // 0 = buy,    1 = sell
               );
        
     }

      //*open first order
      if (OrdersTotal() < intMaxOrders) {
         for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
            OrderSelect(intCurrentOrder, SELECT_BY_POS);
            if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
         }
         if ( (OrderProfit() > 0) && (OrderType() == 1) ) {  // sell 
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }
         
         if ( (OrderProfit() > 0) && (OrderType() == 0) ) {  // buy
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
            
         if ( (OrderProfit() < 0) && (OrderType() == 1) ) {  // sell
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }

         if ( (OrderProfit() < 0) && (OrderType() == 0) ) {  // buy
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
         
       }
    
    }
   
   /*
    //*open first order
   if (OrdersTotal() < intMaxOrders) {
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
   
      if (numRand <= 1) {  // sell 
         if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }
      if (numRand >= 9) {  // buy
         if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
         
    }
    */
      
 
    
   
   return(0);
}
