      subroutine smearing(rhisto_in,inbins,rbinsize,rEres,rhisto_out)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Sep.7 2012
C     
C     ****************************************************
      implicitnone
C     
C     ARGUMENTS 
C     
      integer inbins
      real*8 rhisto_in(inbins),rbinsize,rEres,rhisto_out(inbins)
      
      integer i,j,im
      real*8 rsigma,ra
      
      real*8 Pn
      external Pn
C     ----------
C     BEGIN CODE
C     ----------
      if (rEres.eq.0) then
         do i = 1,inbins
            rhisto_out(i) = rhisto_in(i)
         enddo
      else
         ra = rEres*100
         rsigma = ra*0.005
         im = int(3.5*ra)
         do i = 1,inbins
            rhisto_out(i) = Pn(0,rbinsize,rsigma)*rhisto_in(i)
            do j = 1,im
               rhisto_out(i) = rhisto_out(i) +Pn(j,rbinsize,rsigma)
     &              *( rhisto_in(i+j) +rhisto_in(i-j) )
            enddo
         enddo
      endif

      return
      end



      real*8 function Pn(in,rbinsize,rerror)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Sep.7 2012
C     
C     ****************************************************
      implicitnone
C     
C     ARGUMENTS 
C     
      integer in
      real*8 rbinsize,rerror
      
      integer ierr,inmax
      real*8 rxmin,rxmax,rz(40),racc
      parameter (racc=1d-2, inmax=10)
      
      real*8 wrap_rNormalDist
      external wrap_rNormalDist

C     ----------
C     BEGIN CODE
C     ----------
      rz(1) = 0d0  ! mean of the gauss function
      rz(2) = rerror  ! standard deviation of the gauss function
      
      rxmin = (in-0.5d0)*rbinsize
      rxmax = (in+0.5d0)*rbinsize
      call hsimp1D(wrap_rNormalDist,rxmin,rxmax,rz,Pn,racc,inmax,ierr)
      if (ierr.ne.0) then
         write(6,*) "Pn: Integration does not converge"
         return
      endif

      return
      end


      real*8 function wrap_rNormalDist(rx,rz)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Sep.7 2012
C     
C     ****************************************************
      implicitnone
C      
C     ARGUMENTS 
C     
      real*8 rx,rz(2),rmean,rsigma

      real*8 rNormalDist
      external rNormalDist

C     ----------
C     BEGIN CODE
C     ----------
      wrap_rNormalDist = rNormalDist(rx,rz(1),rz(2))

      return
      end
