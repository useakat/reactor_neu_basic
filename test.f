      program test
      implicitnone

      real*8 z(2),ANS,error
      integer i
      integer iflag,nmax

      real*8 rNormalDist,esbeta,testfunc,SigmaProb
      external rNormalDist,esbeta,testfunc,SigmaProb

      z(1) = 0d0
      z(2) = 1d0

      error = 1d-8
      nmax = 20

c      call simp3d(rNormalDist,0d0,2d0,z,ans,error,nmax,iflag)
c      write(6,*) ans,iflag
c      write(6,*) rNormalDist(0d0,z(1),z(2))

c      call simp1d(testfunc,0d0,0.3d0,ans,error,nmax,iflag)
c      write(6,*) ans,iflag

      open(1,file="dchi2_cl_nostat.dat",status="replace")
      do i = 0,200
         write(1,*) i/10d0,SigmaProb(dsqrt(dble(i)/dble(10)))
      enddo
      do i = 31,50
         write(1,*) i,1d0
      enddo
      close(1)

      end

      real*8 function testfunc(x) 
      implicitnone
      
      real*8 x

      testfunc = x**2 +2*x +4d0

      return
      end

