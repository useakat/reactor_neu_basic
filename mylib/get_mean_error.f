      subroutine get_mean_error(lun,lue,mean,error)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Dec 1 2012
C     ****************************************************
      implicit none

C     ARGUMENTS 
      integer lun,lue
      real*8 mean,error
C     LOCAL VARIABLES 
      integer nline
      real*8 sumx,sum_diff2,x,error2
C     ----------
C     BEGIN CODE
C     ----------
      sumx = 0d0
      nline = 0
      do
         read(lun,*,end=100) x
         sumx = sumx +x 
         nline = nline +1         
      enddo
 100  mean = sumx/dble(nline)
      sum_diff2 = 0d0
      rewind(lun)
      do
         read(lun,*,end=200) x
         sum_diff2 = sum_diff2 +(mean-x)**2 
      enddo
 200  if (nline.gt.1) then
         error2 = sum_diff2/dble(nline-1)
      elseif (nline.eq.1) then
         write(lue,*) "The number of data < 2.",
     &        " Cannot estimate the error.." ,
     &        " Error is set to be 0."
         error2 = 0d0
      endif
      error = dsqrt(error2)

      return
      end
