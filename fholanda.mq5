 
 int intMaxOrders = 8;
 double dlbLot = 0.03;
   
 

int start() {

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
   double iMA5M5  = iMA(NULL,PERIOD_M5,5,0,MODE_SMMA,PRICE_MEDIAN) - SYMBOL_BID;
   double iMA5M15 = iMA(NULL,PERIOD_M15,5,0,MODE_SMMA,PRICE_MEDIAN) - SYMBOL_BID;
   double iMA5M30 = iMA(NULL,PERIOD_M30,5,0,MODE_SMMA,PRICE_MEDIAN) - SYMBOL_BID;
   
   //iMA100
   double iMA15M5  = iMA(NULL,PERIOD_M5,15,0,MODE_SMMA,PRICE_MEDIAN) - SYMBOL_BID;
   double iMA15M15 = iMA(NULL,PERIOD_M15,15,0,MODE_SMMA,PRICE_MEDIAN) - SYMBOL_BID;
   double iMA15M30 = iMA(NULL,PERIOD_M30,15,0,MODE_SMMA,PRICE_MEDIAN) - SYMBOL_BID;
   
   //iMA200
   double iMA30M5  = iMA(NULL,PERIOD_M5,30,0,MODE_SMMA,PRICE_MEDIAN) - SYMBOL_BID;
   double iMA30M15 = iMA(NULL,PERIOD_M15,30,0,MODE_SMMA,PRICE_MEDIAN) - SYMBOL_BID;
   double iMA30M30 = iMA(NULL,PERIOD_M30,30,0,MODE_SMMA,PRICE_MEDIAN) - SYMBOL_BID;
   
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
   
   double iADXM5  = iADX(NULL,PERIOD_M5,14);
   double iADXM15 = iADX(NULL,PERIOD_M15,14);
   double iADXM30 = iADX(NULL,PERIOD_M30,14);
    
   if ((iADXM5) <= 30) { totaliADX++; }
   if ((iADXM15) <= 30) { totaliADX++; }
   if ((iADXM30) <= 30) { totaliADX++; }
   
   medianADX = (iADXM5 + iADXM15 + iADXM30) / 3;
   
   
   
   //-------------------------------------------------------------------------------
   // iac
   
   double iAC5 = iAC(NULL, 5);
   double iAC15 = iAC(NULL, 15);
   double iAC30 = iAC(NULL, 30);
   
   totaliAC = (iAC5 + iAC15 + iAC30) * 100;
   
   
   
   //-------------------------------------------------------------------------------
   //iVolume
   
   double iVolume5 = iVolume(NULL,PERIOD_M5,0);
   double iVolume15 = iVolume(NULL,PERIOD_M15,0);
   double iVolume30 = iVolume(NULL,PERIOD_M30,0);
   
   totaliVolume = (iVolume5 + iVolume15 + iVolume30) / 3000 ;
   
   
   //-------------------------------------------------------------------------------
   //iMomentum
   
   double iMomentum5 = iMomentum(NULL,PERIOD_M5,13,PRICE_CLOSE) - 100 ;
   double iMomentum15 = iMomentum(NULL,PERIOD_M15,13,PRICE_CLOSE) - 100 ;
   double iMomentum30 = iMomentum(NULL,PERIOD_M30,13,PRICE_CLOSE) - 100 ;
   
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
            "\ntotaliMA: " + totaliMA +
            
            //"\n\niADXM5 : " +  DoubleToStr(iADXM5, 0) +
            //"\niADXM15: " +  DoubleToStr(iADXM15, 0) +
            //"\niADXM30: " +  DoubleToStr(iADXM30, 0) +
            "\n\ntotaliADX: " + totaliADX +
            
            //"\n\n\niAC5 : " +  DoubleToStr(iAC5, 2) +
            //"\niAC15 : " +  DoubleToStr(iAC15, 2) +
            //"\niAC30 : " +  DoubleToStr(iAC30, 2) +
            "\n\ntotaliAC: " + totaliAC +
            
            //"\n\niVolume5: " + DoubleToStr(iVolume5, 0) +
            //"\niVolume15: " + DoubleToStr(iVolume15, 0) +
            //"\niVolume30: " + DoubleToStr(iVolume30, 0) +
            "\n\ntotaliVolume: " + totaliVolume +
            
            //"\nmedianADX: " + DoubleToStr(medianADX, 0)
            //"\niMomentum5: " + DoubleToStr(iMomentum5, 2) +
            //"\niMomentum15: " + DoubleToStr(iMomentum15, 2) +
            //"\niMomentum30: " + DoubleToStr(iMomentum30, 2) +
            "\n\ntotaliMomentum: " + totaliMomentum 
            
            
          );
          
    
   //*open orders
   if (OrdersTotal() < intMaxOrders) {
      
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         //OrderSelect(intCurrentOrder, SELECT_BY_POS);
         //if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      //no trend
      if (totaliVolume >= 1) {
         //open orders
         if (totaliMomentum <= -0.5) {  // sell 
            //if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(3*100*Point), Bid-(3*100*Point), "my order#", 8777, 0, Red); }
         }
         if (totaliMomentum >= 0.5) {  // buy
            //if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(3*100*Point), Ask+(3*100*Point), "my order#", 8777, 0, Green); }
         }
     }

   }

   
            
   return(0);
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(void)
  {
//---
   start();
//---
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  }
//+------------------------------------------------------------------+
