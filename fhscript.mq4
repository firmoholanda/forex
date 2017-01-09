int start() {
 
   int intMaxOrders = 4;
   double dlbLot = 0.2;
   
   int intCurrentOrder;
   int ticket;
   int totalIMANeg = 0;
   int totalADXNeg = 0;
   bool haveThisSymbol = false;
 
   
   double imaM1 = iMA(NULL,PERIOD_M1,13,5,MODE_SMMA,PRICE_MEDIAN,0);
   double imaM5 = iMA(NULL,PERIOD_M5,13,5,MODE_SMMA,PRICE_MEDIAN,0);
      
   double iADXM1 = iADX(NULL,PERIOD_M1,13,PRICE_CLOSE,MODE_MAIN,0);
   double iADXM5 = iADX(NULL,PERIOD_M5,13,PRICE_CLOSE,MODE_MAIN,0);

     
   if ((Bid - imaM1) < 0) { totalIMANeg++; }
   if ((Bid - imaM5) < 0) { totalIMANeg++; }
   
   if ((iADXM1) < 30) { totalADXNeg++; }
   if ((iADXM5) < 30) { totalADXNeg++; }
   
   
  
   //comment on chart
   Comment( 
            "\nimaM1 : " +  DoubleToStr(Bid - imaM1, 2) + 
            "\nimaM5 : " +  DoubleToStr(Bid - imaM5, 2) + 
            "\niADXM1 : " +  DoubleToStr(iADXM1, 0) +
            "\niADXM5 : " +  DoubleToStr(iADXM5, 0) +
            "\n\ntotalNeg: " + DoubleToStr(totalIMANeg, 0) +
            "\n\totalADXNeg: " + DoubleToStr(totalADXNeg, 0)
          );
          
    
    //*open orders
   if (OrdersTotal() < intMaxOrders) {
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      if (totalADXNeg <= 0) {  //if have tendency
         if (totalIMANeg >= 2) {  // sell 
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }
         if (totalIMANeg <= 0) {  // buy
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
      }
      if (totalADXNeg >= 2) { //if dont have tendency
         if (totalIMANeg <= 0) {  // sell 
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }
         if (totalIMANeg >= 2) {  // buy
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
      } 
   }
   
            
   return(0);
}