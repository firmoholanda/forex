int intStartTime = 0;
int intTimeLeft = 1;
double dlbLot = 0.1;
int intOrderRepeats = 1;

int start() {
 
   
   int intMaxOrders = 1;
   
   double dblMaxLossProfit = AccountBalance() * (-0.1);
   int intBuySell = 0;  //buy=0, sell=1
   int intTimeTrade = 3;     //time on minutes
   
   int ticket;
   int ticketDell;
   bool haveThisSymbol = false;
   int intCurrentOrder = 0;
   int intTimeDiff = 0;
   
    
   // /*open orders
   if(OrdersTotal() < intMaxOrders) {
      if (intBuySell == 0) {
         for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
            OrderSelect(intCurrentOrder, SELECT_BY_POS);
            if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
         }
         if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, 0, 0, "my order#", 8777, 0, Green);}
         intStartTime = CurTime();
         Sleep(20000);
      }
      if (intBuySell == 1) {
         for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
            OrderSelect(intCurrentOrder, SELECT_BY_POS);
            if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
         }
         if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, 0, 0, "my order#", 8777, 0, Red);}
         intStartTime = CurTime();
         Sleep(20000);
      }
   }
  
  
   //close orders 
   for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
      OrderSelect(intCurrentOrder, SELECT_BY_POS);      
      
     if ( ( (OrderType() == OP_BUY) && (OrderSymbol() == Symbol()) ) && (intTimeLeft <= 0) ) {
         ticketDell = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 3, Silver);
         if (OrderProfit() < 0) { 
            intOrderRepeats++;
            dlbLot = dlbLot * 2;
         }
         if (OrderProfit() > 0) {
            dlbLot = 0.1;
            intTimeLeft = 1;
         }
         Comment( "\nfechar! >= buy");
         Sleep(20000);
      }

      if ( ( (OrderType() == OP_SELL) && (OrderSymbol() == Symbol())) && (intTimeLeft <= 0) ) {
         ticketDell = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 3, Silver);
         if (OrderProfit() < 0) { 
            intOrderRepeats++;
            dlbLot = dlbLot * 2;
         }
         if (OrderProfit() > 0) {
            dlbLot = 0.1;
            intTimeLeft = 1;
         }
         Comment( "\nfechar! <= sell");
         Sleep(20000);         
      } 
   } //*/
   
   
   intTimeDiff = CurTime() - intStartTime;
   intTimeLeft = (intTimeTrade * 60) - intTimeDiff; 
            
   //comment on chart
   Comment( "\nintTimeDiff: " + intTimeDiff  +
            "\nintTimeLeft: " + intTimeLeft  +
            "\ndblProfit: " + DoubleToStr(OrderProfit(), 2) +
            "\nintOrderRepeats: " + intOrderRepeats
          );
            
            
   return(0);
  }