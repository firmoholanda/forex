int start() {
 
   int intMaxOrders = 8;
   double dlbLot = 0.01;
   
   int intCurrentOrder;
   int ticket;
   int ticketDell;
   bool haveThisSymbol = false;
   
   int totaliMA = 0;
   int totaliADX = 0;
   int medianADX = 0;
   double totaliAC = 0;
   double totaliMomentum = 0;
   double totaliVolume = 0;
      
   
   //-------------------------------------------------------------------------------
   //iMAX: moving average
      
   //iMA50
   double iMA5M5  = iMA(NULL,PERIOD_M5,5,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA5M15 = iMA(NULL,PERIOD_M15,5,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA5M30 = iMA(NULL,PERIOD_M30,5,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   
   //iMA100
   double iMA15M5  = iMA(NULL,PERIOD_M5,15,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA15M15 = iMA(NULL,PERIOD_M15,15,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA15M30 = iMA(NULL,PERIOD_M30,15,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   
   //iMA200
   double iMA30M5  = iMA(NULL,PERIOD_M5,30,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA30M15 = iMA(NULL,PERIOD_M15,30,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   double iMA30M30 = iMA(NULL,PERIOD_M30,30,0,MODE_SMMA,PRICE_MEDIAN,0) - Bid;
   
   if ((iMA5M5) > 0) { totaliMA++; }
   if ((iMA5M15) > 0) { totaliMA++; }
   if ((iMA5M30) > 0) { totaliMA++; }
   if ((iMA15M5) > 0) { totaliMA++; }
   if ((iMA15M15) > 0) { totaliMA++; }
   if ((iMA15M30) > 0) { totaliMA++; }
   if ((iMA30M5) > 0) { totaliMA++; }
   if ((iMA30M15) > 0) { totaliMA++; }
   if ((iMA30M30) > 0) { totaliMA++; }


   //-------------------------------------------------------------------------------
   //iADX: Trend Strength Indicator
   //0-25	Absent or Weak Trend
   //25-50	Strong Trend
   //50-75	Very Strong Trend
   //75-100	Extremely Strong Trend
   
   double iADXM5  = iADX(NULL,PERIOD_M5,14,PRICE_CLOSE,MODE_MAIN,0);
   double iADXM15 = iADX(NULL,PERIOD_M15,14,PRICE_CLOSE,MODE_MAIN,0);
   double iADXM30 = iADX(NULL,PERIOD_M30,14,PRICE_CLOSE,MODE_MAIN,0);
    
   if ((iADXM5) <= 30) { totaliADX++; }
   if ((iADXM15) <= 30) { totaliADX++; }
   if ((iADXM30) <= 30) { totaliADX++; }
   
   medianADX = (iADXM5 + iADXM15 + iADXM30) / 3;
   
   
   
   //-------------------------------------------------------------------------------
   // iac
   
   double iAC5 = iAC(NULL, 0, 5);
   double iAC15 = iAC(NULL, 0, 15);
   double iAC30 = iAC(NULL, 0, 30);
   
   totaliAC = (iAC5 + iAC15 + iAC30) * 100;
   
   
   
   //-------------------------------------------------------------------------------
   //iVolume
   
   double iVolume5 = iVolume(NULL,PERIOD_M5,0);
   double iVolume15 = iVolume(NULL,PERIOD_M15,0);
   double iVolume30 = iVolume(NULL,PERIOD_M30,0);
   
   totaliVolume = (iVolume5 + iVolume15 + iVolume30) / 3000 ;
   
   
   //-------------------------------------------------------------------------------
   //iMomentum
   
   double iMomentum5 = iMomentum(NULL,PERIOD_M5,13,PRICE_CLOSE,0) - 100 ;
   double iMomentum15 = iMomentum(NULL,PERIOD_M15,13,PRICE_CLOSE,0) - 100 ;
   double iMomentum30 = iMomentum(NULL,PERIOD_M30,13,PRICE_CLOSE,0) - 100 ;
   
   totaliMomentum = (iMomentum5 + iMomentum15 + iMomentum30);
  
   
   
   //-------------------------------------------------------------------------------
   //comment on chart
   Comment( 
            //"\niMA5M5: " +  DoubleToStr(iMA5M5, 2) +
            //"\niMA5M15: " +  DoubleToStr(iMA5M15, 2) +
            //"\niMA5M30: " +  DoubleToStr(iMA5M30, 2) +
            //"\niMA15M5: " +  DoubleToStr(iMA15M5, 2) +
            //"\niMA15M15: " +  DoubleToStr(iMA15M15, 2) +
            //"\niMA15M30: " +  DoubleToStr(iMA15M30, 2) +
            //"\niMA30M5: " +  DoubleToStr(iMA30M5, 2) +
            //"\niMA30M15: " +  DoubleToStr(iMA30M15, 2) +
            //"\niMA30M30: " +  DoubleToStr(iMA30M30, 2) +
            //"\ntotaliMA: " + DoubleToStr(totaliMA, 0) +
            
            //"\n\niADXM5 : " +  DoubleToStr(iADXM5, 0) +
            //"\niADXM15: " +  DoubleToStr(iADXM15, 0) +
            //"\niADXM30: " +  DoubleToStr(iADXM30, 0) +
            //"\n\ntotaliADX: " + DoubleToStr(totaliADX, 0) +
            
            //"\n\n\niAC5 : " +  DoubleToStr(iAC5, 2) +
            //"\niAC15 : " +  DoubleToStr(iAC15, 2) +
            //"\niAC30 : " +  DoubleToStr(iAC30, 2) +
            //"\ntotaliAC: " + DoubleToStr(totaliAC, 2) 
            
            //"\n\niVolume5: " + DoubleToStr(iVolume5, 0) +
            //"\niVolume15: " + DoubleToStr(iVolume15, 0) +
            //"\niVolume30: " + DoubleToStr(iVolume30, 0) +
            "\ntotaliVolume: " + DoubleToStr(totaliVolume, 2) +
            
            //"\nmedianADX: " + DoubleToStr(medianADX, 0)
            //"\niMomentum5: " + DoubleToStr(iMomentum5, 2) +
            //"\niMomentum15: " + DoubleToStr(iMomentum15, 2) +
            //"\niMomentum30: " + DoubleToStr(iMomentum30, 2) +
            "\ntotaliMomentum: " + DoubleToStr(totaliMomentum, 2) 
            
            
          );
          
    
   //*open orders
   if (OrdersTotal() < intMaxOrders) {
      
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      //no trend
      if (totaliVolume >= 1) {
         //open orders
         if (totaliMomentum <= -0.5) {  // sell 
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }
         if (totaliMomentum >= 0.5) {  // buy
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
     }

   }
            
   return(0);
}

