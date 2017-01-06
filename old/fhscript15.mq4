/*int writeFile() {     
     // whrite file
      int handle;
      handle=FileOpen ("csv01.csv", FILE_CSV|FILE_WRITE|FILE_READ, ';');
      if(handle>0) {
         FileSeek(handle, 0, SEEK_END);
         FileWrite(handle, Symbol(), dbliMFI, dbliADX, slope, intRand);
         FileClose(handle);
      }
} */


//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  

int start() {
 
   double dlbLot = 0.1;
   int intMaxOrders = 9;
      
   int ticket;
   bool haveThisSymbol = false;
   int intCurrentOrder = 0;
   int intCurrentOrderHistory = 0;
   
   double dbliBandsLower = iBands(NULL,0,20,2,0,PRICE_CLOSE,MODE_LOWER,0);
   double dbliBandsUpper = iBands(NULL,0,20,2,0,PRICE_CLOSE,MODE_UPPER,0);
   double dbliBandsMid = (dbliBandsLower + dbliBandsUpper) / 2 ;
   
   double dbliBandsMidLower = (dbliBandsLower + dbliBandsMid) / 2 ;
   double dbliBandsMidUpper = (dbliBandsUpper + dbliBandsMid) / 2 ;
   
   double dbliMFI = iMFI(NULL,0,13,0);
   double dbliADX = iADX(NULL,0,13,PRICE_CLOSE,MODE_MAIN,0);
   int intRand = 1 + 10*MathRand()/32768; // 1-10

   string strComment;
   string strCommentMFI;
   string strCommentADX;
   int handle;
   
   bool UseClose = true;
   int  barsToCount=10;
   
   double a;
   double b;
   double c;
   
   double sumy=0.0;
   double sumx=0.0;
   double sumxy=0.0;
   double sumx2=0.0;

   double LR_line[10];   

   int i;
   
   // calculate linear regression
   for(i=0; i<barsToCount; i++) {
      sumy+=Close[i];
      sumxy+=Close[i]*i;
      sumx+=i;
      sumx2+=i*i;
   }
   
   c=sumx2*barsToCount-sumx*sumx;
   
   if(c==0.0) {
      Alert("Error in linear regression!");
      return;
   }
   
   // Line equation    
   b=(sumxy*barsToCount-sumx*sumy)/c;
   a=(sumy-sumx*b)/barsToCount;
   
   // Linear regression line in buffer
   for(int x=0;x<barsToCount;x++) {
      LR_line[x] = a + (b*x);
   }
      
   double linPrice = LR_line[0];
   double slope = ((LR_line[0]-LR_line[9])/LR_line[9])*100;
   
   //double pDiff = 100-((Bid/LR_line[0])*100);
   
   
   //comment mfi
   //if ( (dbliMFI <= 20) || (dbliMFI >= 80) ) { strCommentMFI = "\niMFI: " + DoubleToStr(dbliMFI, 2) + " #"; }
   //else { strCommentMFI = "\niMFI: " + DoubleToStr(dbliMFI, 2); }
   //comment adx
   //if ( (dbliADX <= 30) ) { strCommentADX = "\niADX: " + DoubleToStr(dbliADX, 2) + " #"; }
   //else { strCommentADX = "\niADX: " + DoubleToStr(dbliADX, 2); }
   
   //int intRand = 0 + 10*MathRand()/32768; // 1-10
   
   double overLine = 0;
   
   //for (int j = 0; 1 < 10; j++) {
      //LR_line[0] - iClose(NULL,NULL,0)
   //   overLine += LR_line[j] - iClose(NULL,NULL,j);
  // }
  
                 
   
   //comment on chart
   Comment( //strCommentMFI + strCommentADX
            //"\niMFI    : " + DoubleToStr(dbliMFI, 2) +
            //"\ndbliBandsMidLower: " + DoubleToStr(dbliBandsMidLower, 5) +
            "\ndbliADX: " + DoubleToStr(dbliADX, 2) 
            //"\nslope    : " + DoubleToStr(slope, 2)          
          );
 
    
    //*open orders
   if (OrdersTotal() < intMaxOrders) {
      for (intCurrentOrder = 0; intCurrentOrder < OrdersTotal(); intCurrentOrder++) {
         OrderSelect(intCurrentOrder, SELECT_BY_POS);
         if (OrderSymbol() == Symbol()) {haveThisSymbol = true;}
      }
      
      // no trend
      /*if (dbliADX <= 20) {
         if ( (slope > 0) ) { // sell
            if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red);}
            Sleep(60000*30); //30 min
         }   
         if ( (slope < 0) ) { // buy
            if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green);}
            Sleep(60000*30); //30 min
         } 
      } */

     // yes trend
     if (dbliADX >= 50) {
         if ( (slope < 0) ) { // sell
            if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_SELL, dlbLot, Bid, 3, Bid+(100*Point), Bid-(100*Point), "my order#", 8777, 0, Red);}
            Sleep(60000*30); //30 min
         }   
         if ( (slope > 0) ) { // buy
            if (!haveThisSymbol) {ticket = OrderSend(Symbol(), OP_BUY, dlbLot, Ask, 3, Ask-(100*Point), Ask+(100*Point), "my order#", 8777, 0, Green);}
            Sleep(60000*30); //30 min
         } 
      }
      
   } 

   return(0);
  }
  
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  