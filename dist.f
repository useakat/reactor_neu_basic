      program dist
      implicit none

      include 'const.inc'

      integer hmode,evform,nevent,snmax,norm
      real*8 z(20),xmin,xmax,serror,ndiv
      real*8 L,P,V,R,Y,Eres,Np,YY
      character*5 cL,cP,cV,cR,cY,cEres

      real*8 hfunc1D_dat
      external hfunc1D_dat

      call getarg(1,cL)
      call getarg(2,cP)
      call getarg(3,cV)
      call getarg(4,cR)
      call getarg(5,cY)
      call getarg(6,cEres)
      read(cL,*) L
      read(cP,*) P
      read(cV,*) V
      read(cR,*) R
      read(cY,*) Y
      read(cEres,*) Eres

      if (V.eq.0d0) then
         Np = 1d0
      else
         Np = V*1d9*R*avog
      endif
      if (Y.eq.0d0) then 
         YY = 1d0
      else
         YY = Y*y2s
      endif
      
      z(1) = 0.852d0
      z(2) = 0.1d0
      z(3) = 7.5d-5
      z(4) = 2.35d-3
      z(5) = L ! L [km]
      z(6) = 1     ! NH/IH
      z(7) = Np   ! N_target
      z(8) = P  ! Power [GW]
      z(9) = YY     ! Exposure time [s]

      xmin = dsqrt(1.01d0)   ! Emin > 1.004
      xmax = dsqrt(7.2d0)
      ndiv = int( (xmax -xmin )/Eres*2d0 )

      nevent = 0
      serror = 1d-2
      snmax = 2

      hmode = 0   
      evform = 2
      norm = 2
      call make_dist(hfunc1D_dat,z,xmin,xmax,ndiv,hmode,evform,nevent
     &     ,serror,snmax,norm,'distxx.dat') ! file name should be 6 characters

      hmode = 1
      evform = 2
      norm = 1
      call make_dist(hfunc1D_dat,z,xmin,xmax,ndiv,hmode,evform,nevent
     &     ,serror,snmax,norm,'dist_h.dat')

      hmode = 2
      evform = 2
      norm = 1
      call make_dist(hfunc1D_dat,z,xmin,xmax,ndiv,hmode,evform,nevent
     &     ,serror,snmax,norm,'disth2.dat')


      end

