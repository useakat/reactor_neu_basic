      real*8 function dchi2(nout,dat,th,nbins,nparm,parm,parm0,error)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 27 2012
C
C     Calculate chi^2 from two real*8 arrays
C     ****************************************************
      implicit none

C     ARGUMENTS 
      integer nbins,nmin,nout,nparm,minevents
      parameter (minevents=0)
      real*8 dat(nbins),th(nbins),parm(nparm),parm0(nparm),error(nparm)
C     LOCAL VARIABLES 
      integer i
      real*8 chi,sgm2,dchi22
C     ----------
C     BEGIN CODE
C     ----------
      dchi2 = 0d0
      do i = 1,nbins
         if (dat(i).ge.minevents) then
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

      dchi22 = 0d0
c      write(6,*) nparm
      do i = 1,nparm
         dchi22 = dchi22 +( parm(i) -parm0(i) )**2 / error(i)**2
      enddo
c      write(6,*) dchi2,dchi22
      dchi2 = dchi2 +dchi22
      

      return
      end


      real*8 function dchi2_2(nout,dat,th,nbins,nparm,parm,parm0,error)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 27 2012
C
C     Calculate chi^2 from two real*8 arrays
C     ****************************************************
      implicit none

C     ARGUMENTS 
      integer nbins,nmin,nout,nparm,minevents
      parameter (minevents=0)
      real*8 dat(nbins),th(nbins),parm(nparm),parm0(nparm),error(nparm)
C     LOCAL VARIABLES 
      integer i,nn,ipos
      real*8 sgm2,dchi22,sumdat,sumth
C     ----------
C     BEGIN CODE
C     ----------
      nn = 1

      dchi2_2 = 0d0
      ipos = 0
      sumdat = 0d0
      sumth = 0d0
      do i = 1,nbins
         if (dat(i).ge.minevents) then
            ipos = ipos +1
            sumdat = sumdat +dat(i)
            sumth = sumth +th(i)
            if (ipos.eq.nn) then
               sgm2 = sumdat
               dchi2_2 = dchi2_2 + ( sumdat -sumth )**2 / sgm2
               ipos = 0
               sumdat = 0d0
               sumth = 0d0
            endif
         elseif (dat(i).ge.0) then
c            write(nout,*) "ERROR: events in ",i,"th bin is too small. " 
c     &           ,"Please reconsider the bin size."
c            stop
         else
            write(nout,*) "ERROR: events in ",i," th bin is negative."
            stop
         endif
      enddo

      dchi22 = 0d0
c      write(6,*) nparm
      do i = 1,nparm
         dchi22 = dchi22 +( parm(i) -parm0(i) )**2 / error(i)**2
      enddo
c      write(6,*) dchi2,dchi22
      dchi2_2 = dchi2_2 +dchi22
      

      return
      end
