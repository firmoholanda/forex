int start() {
 
   int intMaxOrders = 8;
   double dlbLot = 0.1;
   
   int intCurrentOrder;
   int ticket;
   bool haveThisSymbol = false;
   
   int totaliMA = 0;
   int totaliADX = 0;
      
   
   //iMAX: moving average
      
   //iMA50
   double iMA50M5  = iMA(NULL,PERIOD_M5,50,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA50M15 = iMA(NULL,PERIOD_M15,50,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA50M30 = iMA(NULL,PERIOD_M30,50,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   
   //iMA100
   double iMA100M5  = iMA(NULL,PERIOD_M5,100,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA100M15 = iMA(NULL,PERIOD_M15,100,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA100M30 = iMA(NULL,PERIOD_M30,100,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   
   //iMA200
   double iMA200M5  = iMA(NULL,PERIOD_M5,200,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA200M15 = iMA(NULL,PERIOD_M15,200,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA200M30 = iMA(NULL,PERIOD_M30,200,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   
   if ((iMA50M5) > 0) { totaliMA++; }
   if ((iMA50M15) > 0) { totaliMA++; }
   if ((iMA50M30) > 0) { totaliMA++; }
   if ((iMA100M5) > 0) { totaliMA++; }
   if ((iMA100M15) > 0) { totaliMA++; }
   if ((iMA100M30) > 0) { totaliMA++; }
   if ((iMA200M5) > 0) { totaliMA++; }
   if ((iMA200M15) > 0) { totaliMA++; }
   if ((iMA200M30) > 0) { totaliMA++; }


   //iADX: Trend Strength Indicator
   //0-25	Absent or Weak Trend
   //25-50	Strong Trend
   //50-75	Very Strong Trend
   //75-100	Extremely Strong Trend
   
   double iADXM5  = iADX(NULL,PERIOD_M5,14,PRICE_CLOSE,MODE_MAIN,0);
   double iADXM15 = iADX(NULL,PERIOD_M15,14,PRICE_CLOSE,MODE_MAIN,0);
   double iADXM30 = iADX(NULL,PERIOD_M30,14,PRICE_CLOSE,MODE_MAIN,0);
    
   if ((iADXM5) < 30) { totaliADX++; }
   if ((iADXM15) < 30) { totaliADX++; }
   if ((iADXM30) < 30) { totaliADX++; }
   


  
   //comment on chart
   Comment( 
            "\niMA50M5: " +  DoubleToStr(iMA50M5, 0) +
            "\niMA50M15: " +  DoubleToStr(iMA50M15, 0) +
            "\niMA50M30: " +  DoubleToStr(iMA50M30, 0) +
            
            "\n\niMA100M5: " +  DoubleToStr(iMA100M5, 0) +
            "\niMA100M15: " +  DoubleToStr(iMA100M15, 0) +
            "\niMA100M30: " +  DoubleToStr(iMA100M30, 0) +
            
            "\n\niMA200M5: " +  DoubleToStr(iMA200M5, 0) +
            "\niMA200M15: " +  DoubleToStr(iMA200M15, 0) +
            "\niMA200M30: " +  DoubleToStr(iMA200M30, 0) +
            "\n\ntotaliMA: " + DoubleToStr(totaliMA, 0) 
            
            //"\n\niADXM5 : " +  DoubleToStr(iADXM5, 0) +
            //"\niADXM15: " +  DoubleToStr(iADXM15, 0) +
            //"\niADXM30: " +  DoubleToStr(iADXM30, 0) 
            
            //"\n\ntotaliADX: " + DoubleToStr(totaliADX, 0) 
          );
          
    
   //*open orders
   if (OrdersTotal() < intMaxOrders) {
      
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      if (totaliMA <= 1) {  // sell 
         if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         Sleep(300000); //5 min   
      }
      if (totaliMA >= 8) {  // buy
         if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         Sleep(300000); //5 min   
      }
      
      }

   //*/
            
   return(0);
}