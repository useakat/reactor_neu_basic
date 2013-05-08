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


      subroutine smearing_nl(rhisto_in,x,inbins,rbinsize,rEres1,rEres2,rhisto_out)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Sep.7 2012
C     
C     ****************************************************
      implicitnone
C     
C     ARGUMENTS 
C     
      integer inbins
      real*8 rhisto_in(inbins),rbinsize,rEres1,rEres2,rhisto_out(inbins)
      
      integer i,j,im
      real*8 rsigma,ra,rb,x(0:inbins)
      
      real*8 Pn
      external Pn
C     ----------
C     BEGIN CODE
C     ----------
      if ((rEres1.eq.0).and.(rEres2.eq.0)) then
         do i = 1,inbins
            rhisto_out(i) = rhisto_in(i)
         enddo
      else
         ra = rEres1*100
         rb = rEres2
         do i = 1,inbins
            rsigma = dsqrt( (ra*0.005)**2 
     &           +(rb*0.005*( x(i) +x(i-1) )/2d0)**2 )
            im = int(3.5*rsigma/rbinsize)
            rhisto_out(i) = Pn(0,rbinsize,rsigma)*rhisto_in(i)
            do j = 1,im
               rhisto_out(i) = rhisto_out(i) +Pn(j,rbinsize,rsigma)
     &              *( rhisto_in(i+j) +rhisto_in(i-j) )
            enddo
         enddo
      endif

      return
      end


      subroutine smearing_nl2(rhisto_in,x,inbins,rEres1,rEres2,rhisto_out)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS May.8 2013
C     
C     ****************************************************
      implicitnone
C     
C     ARGUMENTS 
C     
      integer inbins
      real*8 rhisto_in(inbins),rbinsize,rEres1,rEres2,rhisto_out(inbins)
      
      integer i,j,immax,immin
      real*8 rsigma,ra,rb,x(0:inbins),EE,maxE,minE
      
      real*8 Pn2
      external Pn2
C     ----------
C     BEGIN CODE
C     ----------
      if ((rEres1.eq.0).and.(rEres2.eq.0)) then
         do i = 1,inbins
            rhisto_out(i) = rhisto_in(i)
         enddo
      else
         ra = rEres1*100
         rb = rEres2
         do i = 1,inbins
            EE = ( x(i) +x(i-1) )/2d0
            rsigma = dsqrt( (ra*0.005)**2 
     &           +(rb*0.005*EE)**2 )
            maxE = EE +3.5*rsigma
            minE = EE -3.5*rsigma
            do j = 0,10
               if (i+j.le.inbins) then
                  if (x(i+j).gt.maxE) immax = j
               else
                  immax = j-1
               endif
            enddo
            do j = 1,10
               if (i-j.ge.0) then
                  if (x(i-j).lt.minE) immin = j-1
               else
                  immin = j-2
               endif
            enddo
            rhisto_out(i) = Pn2(EE,x(i-1),x(i),rsigma)*rhisto_in(i)
            do j = 1,immax
               rhisto_out(i) = rhisto_out(i) +Pn2(EE,x(i+j-1),x(i+j),rsigma)
     &              *rhisto_in(i+j)
            enddo
            do j = 1,immin
               rhisto_out(i) = rhisto_out(i) +Pn2(EE,x(i-j-1),x(i-j),rsigma)
     &              *rhisto_in(i-j)
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


      real*8 function Pn2(rx,rxmin,rxmax,rerror)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS May.8 2013
C     
C     ****************************************************
      implicitnone
C     
C     ARGUMENTS 
C     
      real*8 rerror,rx,rxmin,rxmax
      
      integer ierr,inmax
      real*8 rz(40),racc
      parameter (racc=1d-2, inmax=20)
      
      real*8 wrap_rNormalDist
      external wrap_rNormalDist

C     ----------
C     BEGIN CODE
C     ----------
      rz(1) = rx  ! mean of the gauss function
      rz(2) = rerror  ! standard deviation of the gauss function
      
      call hsimp1D(wrap_rNormalDist,rxmin,rxmax,rz,Pn2,racc,inmax,ierr)
      if (ierr.ne.0) then
         write(6,*) "Pn2: Integration does not converge"
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
