      subroutine get_mean_error(lun,lue,mean,error2,mean_error,
     &     error2_error)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Dec 1 2012
C     ****************************************************
      implicit none

C     ARGUMENTS 
      integer lun,lue
      real*8 mean,error,mean_error,error2_error
C     LOCAL VARIABLES 
      integer nline,nline2
      real*8 sumx,sum_diff2,sum_diff4,x,error2,error2_error2
C     ----------
C     BEGIN CODE
C     ----------
      sumx = 0d0
      nline = 0
c      nline2 = 0
c      open(1,file="error2.dat",status="replace")
c      write(6,*) "1st"
      do
         read(lun,*,end=100) x
c         write(6,*) x
         sumx = sumx +x 
         nline = nline +1         
      enddo
 100  mean = sumx/dble(nline)
c      write(6,*) nline
c      write(6,*) "2nd"
      sum_diff2 = 0d0
      sum_diff4 = 0d0
      rewind(lun)
      do
         read(lun,*,end=200) x
         sum_diff2 = sum_diff2 +(mean-x)**2 
         sum_diff4 = sum_diff4 +(mean-x)**4
c         write(6,*) x,dabs(mean-x),(mean-x)**2,(mean-x)**4
c         nline2 = nline2 +1
      enddo
 200  if (nline.gt.1) then
         error2 = sum_diff2/dble(nline-1)
      elseif (nline.eq.1) then
         write(lue,*) "The number of data < 2.",
     &        " Cannot estimate the error.." ,
     &        " Error is set to be 0."
         error2 = 0d0
      endif
c      write(6,*) nline2
      error2_error2 = 1d0/( (nline-1)*(nline**2 -3*nline +3d0) )
     &     *( nline*sum_diff4 -(nline**2 -3d0)*error2**2 )
c      error_error2 = 1d0/dble(nline)**2*sum_diff4 -error2**2/dble(nline)
c      error_error2 = 2/dble(nline-1)*error2**2
      error2_error = dsqrt(error2_error2)
c      write(6,*) 
c      write(6,*) nline,sum_diff4,error_error2,error_error
c      close(1)
      error = dsqrt(error2)
      mean_error = dsqrt(error2/dble(nline))

      return
      end
