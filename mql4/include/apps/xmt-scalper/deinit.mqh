/**
 * Deinitialization
 *
 * @return int - error status
 */
int onDeinit() {
   int size = ArraySize(metrics.hSet);
   bool success = true;

   for (int i=0; i < size; i++) {
      if (metrics.hSet[i] != 0) {
         if      (i <  6) success = success && HistorySet1.Close(metrics.hSet[i]);
         else if (i < 12) success = success && HistorySet2.Close(metrics.hSet[i]);
         else             success = success && HistorySet3.Close(metrics.hSet[i]);
         metrics.hSet[i] = NULL;
      }
   }

   if (IsTesting()) {
      if (!last_error || last_error==ERR_CANCELLED_BY_USER) {
         if (IsLogInfo()) {
            if (tradingMode!=TRADINGMODE_REGULAR || virt.closedPositions) logInfo("onDeinit(1)  "+ sequence.name +" test stop: "+ virt.closedPositions +" virtual trade"+ Pluralize(virt.closedPositions) +", pl="+ DoubleToStr(virt.closedPl, 2) +", plNet="+ DoubleToStr(virt.closedPlNet, 2));
            if (tradingMode!=TRADINGMODE_VIRTUAL || real.closedPositions) logInfo("onDeinit(2)  "+ sequence.name +" test stop: "+ real.closedPositions +" real trade"+ Pluralize(real.closedPositions) +", pl="+ DoubleToStr(real.closedPl, 2) +", plNet="+ DoubleToStr(real.closedPlNet, 2));
         }
         if (!SaveStatus()) return(last_error);
      }
   }
   return(catch("onDeinit(2)"));
}
