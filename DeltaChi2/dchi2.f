      real*8 function dchi2(nout,dat,th,nbins,nparm,parm,parm0,error)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 27 2012
C
C     Calculate chi^2 from two real*8 arrays
C     ****************************************************
      implicit none

C     ARGUMENTS 
      integer nbins,nmin,nout,nparm
      real*8 dat(nbins),th(nbins),parm(nparm),parm0(nparm),error(nparm)
C     LOCAL VARIABLES 
      integer i
      real*8 chi,sgm2
C     ----------
C     BEGIN CODE
C     ----------
      dchi2 = 0d0

      do i = 1,nbins
         if (dat(i).ge.10) then
            sgm2 = dat(i)
            chi = ( dat(i) -th(i) )**2 / sgm2
            dchi2 = dchi2 + chi
         elseif (dat(i).ge.0) then
c            write(nout,*) "ERROR: events in ",i,"th bin is too small. " 
c     &           ,"Please reconsider the bin size."
c            stop
         else
            write(nout,*) "ERROR: events in ",i," th bin is negative."
            stop
         endif
      enddo

      do i = 1,nparm
         dchi2 = dchi2 +( parm(i) -parm0(i) )**2 / error(i)**2
      enddo

      return
      end
