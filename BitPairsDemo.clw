    PROGRAM

  INCLUDE('JSBitPairsClass.inc')

! * Created with Clarion 10.0
! * User: Jeff Slarve
! * Date: 3/18/2019
! * Time: 8:10 PM

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


BP                  JSBitPairsClass

CheckData           LONG
UseBytes            BYTE,DIM(32)
Ndx                 LONG
FEQ                 LONG
HexString           CSTRING(9)
Window              WINDOW('Bit Pairs Demo'),AT(,,327,335),CENTER,GRAY,FONT('Microsoft Sans S' & |
                        'erif',8),DOUBLE
                        BUTTON('<<<< Copy Left'),AT(89,10,57),USE(?CopyLeftButton)
                        BUTTON('Copy Right >>'),AT(151,10,57,14),USE(?CopyRightButton)
                        ENTRY(@s8),AT(213,10,65),USE(HexString),FONT('Courier New',12)
                        BUTTON('&Close'),AT(283,319,42,14),USE(?CloseButton),STD(STD:Close)
                        PROMPT('The JSBitPairsClass Class allows you to associate a single bit i' & |
                            'n one buffer with a single bit in another buffer.<10,10> For th' & |
                            'e sake of this demo, the checkboxes on the left each USE() a BY' & |
                            'TE. Since there are 32 checkboxes, that makes for easy association with 32 bits.' & |
                            '<10,10> By way of the the BitPairsClass, each of the 32 BYTE' & |
                            'S are associated with each of the 32 BITS of a LONG variable. T' & |
                            'his LONG variable is represented by the hexadecimal ENTRY contr' & |
                            'ol on the right.    If you modify any of the checkboxes, then "' & |
                            'Copy Right", it will modify the hexadecimal on the right. Conve' & |
                            'rsely, if you modify the hexadecimal value on the right, then c' & |
                            'lick "Copy Left", it will update the checkboxes to represent th' & |
                            'at value.'),AT(89,36,215,173),USE(?PROMPT1),FONT(,10)
                        PROMPT('NOTE: You can associate many many bits within one BitPairs objec' & |
                            't or just one. 32 was used for the sake of simplicity.'), |
                            AT(89,212,215,38),USE(?PROMPT2),FONT(,10,,FONT:bold)
                    END

                    MAP
                        MODULE('')
                            LtoA(LONG,*CSTRING,SIGNED),ULONG,RAW,NAME('_ltoa'),PROC !Used for converting to HEX
                        END
                    END


  CODE

        CheckData = RANDOM(1,0FFFFFFFFh) !Setting a random value for the demo
        LtoA(CheckData,HexString,16)     !Getting the hex of our CheckData variable for display
        LOOP Ndx = 1 to 32           
            BP.AddPair(UseBytes[Ndx],1,CheckData,BSHIFT(1,Ndx-1)) !Associating the first bit of each of the 32 UseBytes with 32 bits of the CheckData LONG variable
        END
        BP.AssignRightToLeft !Copying our randomly filled CheckData bits to each of the checkboxes

        OPEN(WINDOW)

        LOOP Ndx = 1 to 32 !Creating some quickie checkboxes because we don't have all day to do this :)
            FEQ            =  CREATE(0,CREATE:check)
            FEQ{PROP:USE } =  UseBytes[Ndx] !Assign the USE variable
            FEQ{PROP:XPOS} =  5
            FEQ{PROP:YPOS} =  Ndx * 10
            FEQ{PROP:TEXT} =  'Bit ' & Ndx
            UNHIDE(FEQ)
        END
        
        ACCEPT
            CASE ACCEPTED()
            OF ?CopyLeftButton       !Normally, this would be done on procedure initialization instead of a button, but this is a demo. You could also do this on the ENTRY control's EVENT:Accepted, but this way is a demo.
                BP.AssignRightToLeft !Copy the values of the 32 bits of Checkdata to each of the 32 bytes of the checkboxes
                DISPLAY
            OF ?CopyRightButton      !Normally, this would be done on the closing of a window or saving of an update form (or even on EVENT:Accepted for the checkboxes, but this is a demo.        
               BP.AssignLeftToRight  !Copy the values of the 32 bytes to each of the 32 bits of CheckData
               LtoA(CheckData,HexString,16) !Get the hex of CheckData for display
               DISPLAY(?HexString)
            OF ?HexString
               CheckData = EVALUATE('0' & HexString & 'h') !Assign the hex representation to the LONG 
            END
            
        END
        