int curTick;


int start() {
 
   double dlbLot = 1;
   int intMaxOrders = 1;
   
   double dblMargin = (dlbLot) * (AccountBalance() * 0.03);
   
   double dblLowerPrice = dblMargin * (-1);
   double dblUpperPrice = dblMargin * 1;
   
   
   double dblRandNumb = MathRand() - 16383.5;
   double dblProfit[5];
  
   
   
   int ticket;
   int ticketDell;
   bool haveThisSymbol = false;
   int intCurrentOrder = 0;
   
   double dblTendencia = iADX(Symbol(), 0, 10, PRICE_MEDIAN, MODE_MAIN, 0);
   double dblMFI = iMFI(Symbol(),0,10,0);
   double dblMFILong = iMFI(Symbol(),0,50,0);
   
    //OrderSelect(0, SELECT_BY_POS);
   
   /*open orders
   if(OrdersTotal() < intMaxOrders) {
      if (dblRandNumb > 0)  {
         for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
            OrderSelect(intCurrentOrder, SELECT_BY_POS);
            if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
         }
         if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, 0, 0, "my order#", 8777, 0, Green);}
      }
      if (dblRandNumb <= 0)  {
         for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
            OrderSelect(intCurrentOrder, SELECT_BY_POS);
            if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
         }
         if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, 0, 0, "my order#", 8777, 0, Red);}
      }
   } */
  
  
   //close orders 
   for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
      OrderSelect(intCurrentOrder, SELECT_BY_POS);
      
      /*
      if (OrderProfit() < 0) {
         double dblLowerPrice = dblMargin * (-1);
         //double dblUpperPrice = dblMargin * 1;
      }
      if (OrderProfit() > 0) {
         dblProfit[curTick-1] = OrderProfit();
         dblLowerPrice = (dblProfit[0]+dblProfit[1]+dblProfit[2]+dblProfit[3]+dblProfit[4]) / 5;
      }
      */
      
          
      if ( ( (OrderType() == OP_BUY) && (OrderSymbol() == Symbol()) ) && ( (OrderProfit() <= dblLowerPrice) )) { //|| (OrderProfit() >= dblUpperPrice) ) ) {
         ticketDell = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 3, Silver);
         Comment( "\nfechar! >= buy");
         Sleep(1000);
      }

      if ( ( (OrderType() == OP_SELL) && (OrderSymbol() == Symbol())) && ( (OrderProfit() <= dblLowerPrice) )) { //|| (OrderProfit() >= dblUpperPrice) ) ){
         ticketDell = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 3, Silver);
         Comment( "\nfechar! <= sell");
         Sleep(1000);         
      } 
   }
   
   
   //comment on chart
   Comment( "\ndblLowerPrice: " + DoubleToStr(dblLowerPrice, 2) +
            "\ndblUpperPrice: " + DoubleToStr(dblUpperPrice, 2) +
            //"\nOrderProfit(): " + DoubleToStr(OrderProfit(), 5) +
            "\nndblTendencia: " + DoubleToStr(dblTendencia, 2) +
            "\ndblMFI: " + DoubleToStr(dblMFI, 2) );
   
   if (curTick == 5) {curTick = 0;}
   curTick++;
   
   
   return(0);
  }