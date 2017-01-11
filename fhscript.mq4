int start() {
 
   int intMaxOrders = 4;
   double dlbLot = 0.2;
   
   int intCurrentOrder;
   int ticket;
   bool haveThisSymbol = false;
   
   int totaliIMA = 0;
   int totaliADX = 0;
   int totaliForce = 0;
   
 
   
   double imaM1 = iMA(NULL,PERIOD_M1,13,5,MODE_SMMA,PRICE_MEDIAN,0)*10;
   double imaM5 = iMA(NULL,PERIOD_M5,13,5,MODE_SMMA,PRICE_MEDIAN,0)*10;
      
   double iADXM1 = iADX(NULL,PERIOD_M1,13,PRICE_CLOSE,MODE_MAIN,0);
   double iADXM5 = iADX(NULL,PERIOD_M5,13,PRICE_CLOSE,MODE_MAIN,0);
   
   double iForceM1 = iForce(NULL,PERIOD_M1,13,MODE_SMA,PRICE_CLOSE,0)*1000;
   double iForceM5 = iForce(NULL,PERIOD_M5,13,MODE_SMA,PRICE_CLOSE,0)*1000;


     
   if ((Bid - imaM1) > 0) { totaliIMA++; }
   if ((Bid - imaM5) > 0) { totaliIMA++; }
   
   if ((iADXM1) < 30) { totaliADX++; }
   if ((iADXM5) < 30) { totaliADX++; }
   
   if ((iForceM1) > 0) { totaliForce++; }
   if ((iForceM5) > 0) { totaliForce++; }
   
   
  
   //comment on chart
   Comment( 
            "\nimaM1 : " +  DoubleToStr(Bid - imaM1, 2) + 
            "\nimaM5 : " +  DoubleToStr(Bid - imaM5, 2) + 
            "\niADXM1 : " +  DoubleToStr(iADXM1, 0) +
            "\niADXM5 : " +  DoubleToStr(iADXM5, 0) +
            "\niForceM1 : " +  DoubleToStr(iForceM1, 2) +
            "\niForceM5 : " +  DoubleToStr(iForceM5, 2) +
            "\n\ntotaliIMA: " + DoubleToStr(totaliIMA, 0) +
            "\n\totaliADX: " + DoubleToStr(totaliADX, 0)
          );
          
    
    //*open orders
   if (OrdersTotal() < intMaxOrders) {
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      if (totaliADX >= 2) { //if dont have tendency
         if (totaliIMA >= 2) {  // sell 
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }
         if (totaliIMA <= 0) {  // buy
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
      } 
   }
   
            
   return(0);
}