int start() {
 
   int intMaxOrders = 4;
   double dlbLot = 0.3;
   
   int intCurrentOrder;
   int ticket;
   bool haveThisSymbol = false;
   
   int totaliADX = 0;
   int totaliForce = 0;
   
   
   double iADXM5 = iADX(NULL,PERIOD_M5,13,PRICE_CLOSE,MODE_MAIN,0);
   double iADXM15 = iADX(NULL,PERIOD_M15,13,PRICE_CLOSE,MODE_MAIN,0);
   double iADXM30 = iADX(NULL,PERIOD_M30,13,PRICE_CLOSE,MODE_MAIN,0);
   
   double dbliBandsUpper = iBands(NULL,0,20,2,0,PRICE_CLOSE,MODE_UPPER,0);
   double dbliBandsLower = iBands(NULL,0,20,2,0,PRICE_CLOSE,MODE_LOWER,0);
   
   
   if ((iADXM5) < 30) { totaliADX++; }
   if ((iADXM15) < 30) { totaliADX++; }
   if ((iADXM30) < 30) { totaliADX++; }

  
   //comment on chart
   Comment( 
            "\niADXM5 : " +  DoubleToStr(iADXM5, 0) +
            "\niADXM15: " +  DoubleToStr(iADXM15, 0) +
            "\niADXM30: " +  DoubleToStr(iADXM30, 0) +
            //"\ndbliBandsUpper: " +  DoubleToStr(dbliBandsUpper, 5) +
            //"\ndbliBandsLower: " +  DoubleToStr(dbliBandsLower, 5) +
            //"\ndblBid: " +  DoubleToStr(Bid, 5) +
            "\n\ntotaliADX: " + DoubleToStr(totaliADX, 0) 
          );
          
    
    //*open orders
   if (OrdersTotal() < intMaxOrders) {
      
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      if (totaliADX >= 3) { //if dont have tendency
         if (Bid >= dbliBandsUpper) {  // sell 
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
            Sleep(300000); //5 min   
         }
         if (Bid <= dbliBandsLower) {  // buy
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
            Sleep(300000); //5 min   
         }
      } 
      
   }
   
            
   return(0);
}
