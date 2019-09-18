int start() {
 
   int intMaxOrders = 4;
   double dlbLot = 0.2;
   
   int intCurrentOrder;
   int ticket;
   int totalNeg = 0;
   bool haveThisSymbol = false;
 
   double dbliADX = iADX(NULL,0,13,PRICE_CLOSE,MODE_MAIN,0);

   double imaM1 = iMA(NULL,PERIOD_M1,13,5,MODE_SMMA,PRICE_MEDIAN,0);
   double imaM5 = iMA(NULL,PERIOD_M5,13,5,MODE_SMMA,PRICE_MEDIAN,0);
   double imaM15 = iMA(NULL,PERIOD_M15,13,5,MODE_SMMA,PRICE_MEDIAN,0);
   double imaM30 = iMA(NULL,PERIOD_M30,13,5,MODE_SMMA,PRICE_MEDIAN,0);
   double imaH1 = iMA(NULL,PERIOD_H1,13,5,MODE_SMMA,PRICE_MEDIAN,0);
   double imaH4 = iMA(NULL,PERIOD_H4,13,5,MODE_SMMA,PRICE_MEDIAN,0);
   double imaD1 = iMA(NULL,PERIOD_D1,13,5,MODE_SMMA,PRICE_MEDIAN,0);
   double imaW1 = iMA(NULL,PERIOD_W1,13,5,MODE_SMMA,PRICE_MEDIAN,0);
   double imaMN1 = iMA(NULL,PERIOD_MN1,13,5,MODE_SMMA,PRICE_MEDIAN,0);

     
   if ((Bid - imaM1) < 0) { totalNeg++; }
   if ((Bid - imaM5) < 0) { totalNeg++; }
   //if ((Bid - imaM15) < 0) { totalNeg++; }
   //if ((Bid - imaM30) < 0) { totalNeg++; }
   //if ((Bid - imaH1) < 0) { totalNeg++; }
   //if ((Bid - imaH4) < 0) { totalNeg++; }
   //if ((Bid - imaD1) < 0) { totalNeg++; }
   //if ((Bid - imaW1) < 0) { totalNeg++; }
   //if ((Bid - imaMN1) < 0) { totalNeg++; }
   
   
  
   //comment on chart
   Comment( 
            "\nimaM1 : " +  DoubleToStr(Bid - imaM1, 2) + 
            "\nimaM5 : " +  DoubleToStr(Bid - imaM5, 2) + 
            "\ndbliADX : " +  DoubleToStr(dbliADX, 0) +
           // "\nimaM15: " + DoubleToStr(Bid - imaM15, 2) + 
           // "\nimaM30: " + DoubleToStr(Bid - imaM30, 2) + 
           // "\nimaH1 : " +  DoubleToStr(Bid - imaH1, 2) + 
           // "\nimaH4 : " +  DoubleToStr(Bid - imaH4, 2) + 
           // "\nimaD1 : " +  DoubleToStr(Bid - imaD1, 2) + 
           // "\nimaW1 : " +  DoubleToStr(Bid - imaW1, 2) +
           // "\nimaMN1: " + DoubleToStr(Bid - imaMN1, 2) + 
            "\n\ntotalNeg: " + DoubleToStr(totalNeg, 0)
          );
          
    
    //*open orders
   if (OrdersTotal() < intMaxOrders) {
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      if (dbliADX > 40) {
         if (totalNeg >= 2) {  // sell 
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }
         if (totalNeg <= 0) {  // buy
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
      }
      else {
         if (totalNeg <= 0) {  // sell 
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red); }
         }
         if (totalNeg >= 2) {  // buy
            if (!haveThisSymbol) { ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green); }
         }
      }
      
   }
   
            
   return(0);
}