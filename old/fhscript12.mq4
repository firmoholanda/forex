
int start() {
 
   double dlbLot = 1;
   int intMaxOrders = 3;
   
   int ticket;
   int ticketDell;
   bool haveThisSymbol = false;
   int intCurrentOrder = 0;
   
   double dbliBandsLower = iBands(NULL,0,20,2,0,PRICE_CLOSE,MODE_LOWER,0);
   double dbliBandsUpper = iBands(NULL,0,20,2,0,PRICE_CLOSE,MODE_UPPER,0);
   double dbliBandsMid = (dbliBandsLower + dbliBandsUpper) / 2 ;
   
   double dbliADX = iADX(NULL,0,14,PRICE_CLOSE,MODE_MAIN,0);
   //double dbliADXPlus = iADX(NULL,0,14,PRICE_CLOSE,MODE_PLUSDI,0);
   //double dbliADXMinus = iADX(NULL,0,14,PRICE_CLOSE,MODE_MINUSDI,0);
   //double dbliADXSignal = dbliADXPlus- dbliADXMinus;
   
   double dbliMAFast = iMA(NULL,0,6,0,MODE_EMA,PRICE_CLOSE,0);
   double dbliMASlow = iMA(NULL,0,12,0,MODE_EMA,PRICE_CLOSE,0);
   //double dblDiffiMA = (dbliMAFast - dbliMASlow) * 100000;  
   
   //comment on chart
   Comment( 
            "\ndbliMAFast: " + DoubleToStr(dbliMAFast, 5) +
            "\ndbliMASlow: " + DoubleToStr(dbliMASlow, 5) +
            "\nbliBandsLower: " + DoubleToStr(dbliBandsLower, 5) +
            "\nbliBandsUpper: " + DoubleToStr(dbliBandsUpper, 5) +
            "\ndbliBandsMid: " + DoubleToStr(dbliBandsMid, 5) 
          );
          
    
    /*open orders
   //if (dbliADX >= 25) {
      if (OrdersTotal() < intMaxOrders) {
         for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
            OrderSelect(intCurrentOrder, SELECT_BY_POS);
            if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
         }
      
         if (dblDiffiMA >= 30) {
            if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, 0, 0, "my order#", 8777, 0, Green);}
            Sleep(300000); //wait 5 min
         }
         if (dblDiffiMA <= -30) {
            if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, 0, 0, "my order#", 8777, 0, Red);}
            Sleep(300000); //wait 5 min
         }
      } 
  // }
  
  
   // /*close orders 
   for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
      OrderSelect(intCurrentOrder, SELECT_BY_POS);  
      
     if ( ( (OrderType() == OP_BUY) && (OrderSymbol() == Symbol()) ) && (dblDiffiMA < 0) || (OrderProfit() <= -2000)  ) { //((dblPriceDiff <= 0) && ((OrderProfit() > 0) && (OrderProfit() > dblLastProfit)) ) ) {
         ticketDell = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 3, Silver);
         Comment( "\nfechar! >= buy");
         Sleep(300000); //wait 5 min
      }

      if ( ( (OrderType() == OP_SELL) && (OrderSymbol() == Symbol())) && (dblDiffiMA > 0) || (OrderProfit() <= -2000) ) { // && ((dblPriceDiff >= 0) && ((OrderProfit() > 0) && (OrderProfit() < dblLastProfit)) ) ) {
         ticketDell = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 3, Silver);
         Comment( "\nfechar! <= sell");
         Sleep(300000); //wait 5 min
      } 
   }    */
            
            
   return(0);
  }