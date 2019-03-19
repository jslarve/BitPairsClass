  MEMBER

    INCLUDE('JSBitPairsClass.inc'),ONCE

! * Created with Clarion 10.0
! * User: Jeff Slarve
! * Date: 7/21/2018
! * Time: 10:22 AM

!MIT License
!
!Copyright (c) 2019 Jeff Slarve
!
!Permission is hereby granted, free of charge, to any person obtaining a copy
!of this software and associated documentation files (the "Software"), to deal
!in the Software without restriction, including without limitation the rights
!to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
!copies of the Software, and to permit persons to whom the Software is
!furnished to do so, subject to the following conditions:
!
!The above copyright notice and this permission notice shall be included in all
!copies or substantial portions of the Software.
!
!THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
!IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
!FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
!AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
!LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
!OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
!SOFTWARE.


  MAP
  END


JSBitPairsClass.AddPair   PROCEDURE(*? pLeftBits,LONG pLeftMask,*? pRightBits,LONG pRightMask)

   CODE

? ASSERT(~(SELF.BitQ &= NULL))
  CLEAR(SELF.BitQ)
  SELF.BitQ.LeftBits  &= pLeftBits
  SELF.BitQ.RightBits &= pRightBits
  SELF.BitQ.LeftMask   = pLeftMask
  SELF.BitQ.RightMask  = pRightMask
  ADD(SELF.BitQ)
  RETURN POINTER(SELF.BitQ)      

JSBitPairsClass.AssignLeftToRight PROCEDURE(LONG pRecord=0)
Ndx  LONG
Recs LONG

    CODE

  IF pRecord
     GET(SELF.BitQ,pRecord)
     IF NOT ERRORCODE()
        DO TheAssign
     END       
  ELSE
    Recs = RECORDS(SELF.BitQ)
    LOOP Ndx = 1 TO Recs
      GET(SELF.BitQ,Ndx)
      DO TheAssign
      SELF.TakeAssignRecord(Ndx,Recs)
    END
  END

TheAssign           ROUTINE

    IF BAND(SELF.BitQ.LeftBits,SELF.BitQ.LeftMask) = SELF.BitQ.LeftMask
       SELF.BitQ.RightBits = BOR(SELF.BitQ.RightBits,SELF.BitQ.RightMask)
    ELSE
       SELF.BitQ.RightBits = BXOR(SELF.BitQ.RightBits,BAND(SELF.BitQ.RightBits,SELF.BitQ.RightMask))
    END
    PUT(SELF.BitQ) 
    
    
JSBitPairsClass.AssignRightToLeft PROCEDURE(LONG pRecord=0)
Ndx  LONG
Recs LONG

    CODE

  IF pRecord
     GET(SELF.BitQ,pRecord)
     IF NOT ERRORCODE()
        DO TheAssign
     END       
  ELSE
    Recs = RECORDS(SELF.BitQ)
    LOOP Ndx = 1 TO Recs
      GET(SELF.BitQ,Ndx)
      DO TheAssign
      SELF.TakeAssignRecord(Ndx,Recs)
    END
  END
    
TheAssign           ROUTINE

  IF BAND(SELF.BitQ.RightBits,SELF.BitQ.RightMask) = SELF.BitQ.RightMask
     SELF.BitQ.LeftBits = BOR(SELF.BitQ.LeftBits,SELF.BitQ.LeftMask)
  ELSE
     SELF.BitQ.LeftBits = BXOR(SELF.BitQ.LeftBits,BAND(SELF.BitQ.LeftBits,SELF.BitQ.LeftMask))
  END
  PUT(SELF.BitQ)
    
JSBitPairsClass.ClearLeft PROCEDURE
Ndx LONG

   CODE

  LOOP Ndx = 1 TO RECORDS(SELF.BitQ)
    GET(SELF.BitQ,Ndx)
    SELF.BitQ.LeftBits = BXOR(SELF.BitQ.LeftBits,BAND(SELF.BitQ.LeftBits,SELF.BitQ.LeftMask))
    PUT(SELF.BitQ)
  END

JSBitPairsClass.ClearRight PROCEDURE
Ndx LONG

   CODE

  LOOP Ndx = 1 TO RECORDS(SELF.BitQ)
    GET(SELF.BitQ,Ndx)
    SELF.BitQ.RightBits = BXOR(SELF.BitQ.RightBits,BAND(SELF.BitQ.RightBits,SELF.BitQ.RightMask))
    PUT(SELF.BitQ)
  END


JSBitPairsClass.Construct PROCEDURE

   CODE
  
  SELF.BitQ &= NEW JSBitPairsQ
  
JSBitPairsClass.Destruct PROCEDURE
Ndx LONG
   CODE
  
  IF NOT SELF.BitQ &= NULL
    LOOP Ndx = RECORDS(SELF.BitQ) TO 1 BY -1
    	GET(SELF.BitQ,Ndx)
    	IF ERRORCODE()
    	  BREAK
    	END
    	SELF.BitQ.LeftBits  &= NULL
    	SELF.BitQ.RightBits &= NULL
    	DELETE(SELF.BitQ)
    END
    DISPOSE(SELF.BitQ)
  END

JSBitPairsClass.Records           PROCEDURE

  CODE
  
  RETURN RECORDS(SELF.BitQ)

JSBitPairsClass.TakeAssignRecord  PROCEDURE(LONG pNdx,LONG pRecords)!,VIRTUAL

  CODE
  
  !Virtual Method

                