
int start() {
 
   double dlbLot = 1;
   int intMaxOrders = 1;
   
   
   double dblTendenciaLower = 20; 
   double dblMFIUpper = 80;
   double dblMFILower = 20;
   double dblMFIMidUpper = 60;  //55
   double dblMFIMidLower = 40;  //45
   
   double dblMaxLossProfit = AccountBalance() * (-0.1);
   
   int ticket;
   int ticketDell;
   bool haveThisSymbol = false;
   int intCurrentOrder = 0;
   
   double dblTendencia = iADX(Symbol(), 0, 13, PRICE_MEDIAN, MODE_MAIN, 0);
   double dblMFI = iMFI(Symbol(),0,13,0);
   //double dblMFILong = iMFI(Symbol(),0,50,0);
   
     
   // /*open orders
   if(OrdersTotal() < intMaxOrders) {
      if (dblTendencia <= dblTendenciaLower) {
         if ( (dblMFI <= dblMFILower) )  { //&& (dblMFILong <= 40) )  {
            for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
               OrderSelect(intCurrentOrder, SELECT_BY_POS);
               if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
            }
            if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, 0, 0, "my order#", 8777, 0, Green);}
         }
         if ( (dblMFI >= dblMFIUpper) )  { //&& (dblMFILong >= 60) )  {
            for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
               OrderSelect(intCurrentOrder, SELECT_BY_POS);
               if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
            }
            if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, 0, 0, "my order#", 8777, 0, Red);}
         }
      }
   }
  
  
   //close orders 
   for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
      OrderSelect(intCurrentOrder, SELECT_BY_POS);      
      
      if ( ( (OrderType() == OP_BUY) && (OrderSymbol() == Symbol()) ) && ((dblMFI >= dblMFIMidLower) || (OrderProfit() <= dblMaxLossProfit)) ) {
         ticketDell = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 3, Silver);
         Comment( "\nfechar! >= buy");
         Sleep(1000);
      }

      if ( ( (OrderType() == OP_SELL) && (OrderSymbol() == Symbol())) && ((dblMFI <= dblMFIMidUpper) || (OrderProfit() <= dblMaxLossProfit)) ) {
         ticketDell = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 3, Silver);
         Comment( "\nfechar! <= sell");
         Sleep(1000);         
      } 
   } //*/
            
            
   //comment on chart
   Comment( //"\ndblOrdersTotal(): " + DoubleToStr(OrdersTotal(), 2) +
            "\ndblTendencia: " + DoubleToStr(dblTendencia, 2) +
            "\ndblProfit: " + DoubleToStr(OrderProfit(), 2) +
            "\ndbldblMaxLossProfit: " + DoubleToStr(dblMaxLossProfit, 2) +
            "\ndblMFI: " + DoubleToStr(dblMFI, 2) );
            
            
   return(0);
  }