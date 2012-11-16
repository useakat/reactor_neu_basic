      real*8 function chi2(nout,dat,th,nbins,nparm,parm,parm0,error)
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
      real*8 chi,sgm2,chi22
C     ----------
C     BEGIN CODE
C     ----------
      chi2 = 0d0
      do i = 1,nbins
         if (dat(i).ge.minevents) then
            sgm2 = dat(i)
            chi = ( dat(i) -th(i) )**2 / sgm2
            chi2 = chi2 + chi
         elseif (dat(i).ge.0) then
c            write(nout,*) "ERROR: events in ",i,"th bin is too small. " 
c     &           ,"Please reconsider the bin size."
c            stop
         else
            write(nout,*) "ERROR: events in ",i," th bin is negative."
            stop
         endif
      enddo

      chi22 = 0d0
      do i = 1,nparm
         chi22 = chi22 +( parm(i) -parm0(i) )**2 / error(i)**2
      enddo
      chi2 = chi2 +chi22
      

      return
      end


      real*8 function chi2_2(nout,dat,th,nbins,nparm,parm,parm0,error)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 27 2012
C
C     Calculate chi^2 from two real*8 arrays
C     ****************************************************
      implicit none

C     ARGUMENTS 
      integer nbins,nmin,nout,nparm,minevents
      parameter (minevents=10)
      real*8 dat(nbins),th(nbins),parm(nparm),parm0(nparm),error(nparm)
C     LOCAL VARIABLES 
      integer i,nn,ipos
      real*8 sgm2,chi22,sumdat,sumth
      integer ifirst
      real*8 final_bins
      common /first/ ifirst, final_bins
C     ----------
C     BEGIN CODE
C     ----------
      nn = 1

      final_bins = 0
      chi2_2 = 0d0
      ipos = 0
      sumdat = 0d0
      sumth = 0d0
      open(41,file="final_bining.dat",status="replace")
      do i = 1,nbins
         ipos = ipos +1
         sumdat = sumdat +dat(i)
         sumth = sumth +th(i)
         if (ipos.eq.nn) then
            if (sumdat.ge.minevents) then
               write(41,*) i,sumdat
               final_bins = final_bins + 1
               sgm2 = sumdat
               chi2_2 = chi2_2 + ( sumdat -sumth )**2 / sgm2
               ipos = 0
               sumdat = 0d0
               sumth = 0d0
            elseif (sumdat.ge.0) then
               ipos = ipos -1
c               write(nout,*) "Events in ",i,"th bin is less than "
c     &              ,minevents,"."
            else
               write(nout,*) "ERROR: events in ",i
     &              ," th bin is negative."
               stop
            endif
         endif
      enddo
      close(41)
      
      chi22 = 0d0
      do i = 1,nparm
         chi22 = chi22 +( parm(i) -parm0(i) )**2 / error(i)**2
      enddo
      chi2_2 = chi2_2 +chi22
      

      return
      end
