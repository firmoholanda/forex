int start() {
 
   int intMaxOrders = 4;
   double dlbLot = 0.2;
   
   int intCurrentOrder;
   int ticket;
   bool haveThisSymbol = false;
   
   int totaliADX = 0;
   int totaliForce = 0;
   
   
   double iADXM1 = iADX(NULL,PERIOD_M1,13,PRICE_CLOSE,MODE_MAIN,0);
   double iADXM5 = iADX(NULL,PERIOD_M5,13,PRICE_CLOSE,MODE_MAIN,0);
   double iADXM15 = iADX(NULL,PERIOD_M15,13,PRICE_CLOSE,MODE_MAIN,0);
   
   double iForceM1 = iForce(NULL,PERIOD_M1,13,MODE_SMA,PRICE_CLOSE,0)*1000;
   double iForceM5 = iForce(NULL,PERIOD_M5,13,MODE_SMA,PRICE_CLOSE,0)*1000;
   double iForceM15 = iForce(NULL,PERIOD_M15,13,MODE_SMA,PRICE_CLOSE,0)*1000;

   
   if ((iADXM1) < 30) { totaliADX++; }
   if ((iADXM5) < 30) { totaliADX++; }
   if ((iADXM15) < 30) { totaliADX++; }
   
   if ((iForceM1) > 0) { totaliForce++; }
   if ((iForceM5) > 0) { totaliForce++; }
   if ((iForceM15) > 0) { totaliForce++; }
   
   
  
   //comment on chart
   Comment( 
            "\niADXM1 : " +  DoubleToStr(iADXM1, 0) +
            "\niADXM5 : " +  DoubleToStr(iADXM5, 0) +
            "\niADXM15 : " +  DoubleToStr(iADXM15, 0) +
            "\niForceM1: " +  DoubleToStr(iForceM1, 2) +
            "\niForceM5: " +  DoubleToStr(iForceM5, 2) +
            "\niForceM15: " +  DoubleToStr(iForceM15, 2) +
            "\n\n\totaliADX: " + DoubleToStr(totaliADX, 0) +
            "\n\totaliForce: " + DoubleToStr(totaliForce, 0)
          );
          
    
    //*open orders
   if (OrdersTotal() < intMaxOrders) {
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      if (totaliADX >= 3) { //if dont have tendency
         if (totaliForce <= 0) {  // sell 
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }
         if (totaliForce >= 3) {  // buy
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
      } 
   }
   
            
   return(0);
}
