!ABCIncludeFile

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


 OMIT('_EndOfInclude_',_JSBitPairsPresent_)

_JSBitPairsPresent_ EQUATE(1)


JSBitPairsQ     QUEUE,TYPE
LeftBits          ANY
LeftMask          LONG
RightBits         ANY
RightMask         LONG
                end
              
JSBitPairsClass CLASS,TYPE,MODULE('JSBitPairsClass.clw'),LINK('JSBitPairsClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
BitQ              &JSBitPairsQ,PRIVATE
AddPair           PROCEDURE(*? pLeftBits,LONG pLeftMask,*? pRightBits,LONG pRightMask),LONG,PROC
AssignLeftToRight PROCEDURE(LONG pRecord=0)
AssignRightToLeft PROCEDURE(LONG pRecord=0)
ClearLeft         PROCEDURE
ClearRight        PROCEDURE
Construct         PROCEDURE
Destruct          PROCEDURE
Records           PROCEDURE(),LONG                           !How many bits are associated
TakeAssignRecord  PROCEDURE(LONG pNdx,LONG pRecords),VIRTUAL !For progress controls when there are lots of bits to process
                end
              
  _EndOfInclude_


