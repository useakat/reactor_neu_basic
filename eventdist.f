      program eventdist
      implicit none

      include 'const.inc'

      integer i
      integer hmode,evform,nevent,snmax,norm
      real*8 z(20),xmin,xmax,serror,ndiv,nbins
      real*8 L,P,V,R,Y,Eres,Np,YY
      real*8 eventnh(10000),neventnh,eventih(10000),neventih
      real*8 dchi2
      character*5 cL,cP,cV,cR,cY,cEres

      real*8 feventdist
      external feventdist

      call getarg(1,cL)
      call getarg(2,cP)
      call getarg(3,cV)
      call getarg(4,cR)
      call getarg(5,cY)
      read(cL,*) L
      read(cP,*) P
      read(cV,*) V
      read(cR,*) R
      read(cY,*) Y

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

      nevent = 0
      serror = 1d-2
      snmax = 2

      ndiv = 10000
      hmode = 0     ! 0:smooth, 1:simpson 2:center value   
      evform = 2    ! 1:integer 2:real*8
      norm = 1      ! 1:event/dx 2:event
      call make_dist(feventdist,z,xmin,xmax,ndiv,hmode,evform,nevent
     &     ,serror,snmax,norm,'evdist.dat') ! file name should be 6 characters

      open(2,file='deltachi2.txt',status='replace')
      hmode = 1
      evform = 1
      norm = 2

      Eres = 0.06d0
      ndiv = (xmax -xmin )/Eres*2d0
      z(6) = 1     ! NH/IH
      call make_dist_event(feventdist,z,xmin,xmax,ndiv,hmode,evform
     &     ,nevent,serror,snmax,norm,'edh6nh.dat',eventnh,neventnh)
      z(6) = -1     ! NH/IH
      call make_dist_event(feventdist,z,xmin,xmax,ndiv,hmode,evform
     &     ,nevent,serror,snmax,norm,'edh6ih.dat',eventih,neventih)
      dchi2 = 0d0
      do i = 1,ndiv
         dchi2 = dchi2 +( eventnh(i) -eventih(i) )**2 / eventnh(i)
      enddo
      write(2,*) "Naive Delta-Chi2(NH,6%) = ",dchi2
      dchi2 = 0d0
      do i = 1,ndiv
         dchi2 = dchi2 +( eventnh(i) -eventih(i) )**2 / eventih(i)
      enddo
      write(2,*) "Naive Delta-Chi2(IH,6%) = ",dchi2

      Eres = 0.03d0
      ndiv = (xmax -xmin )/Eres*2d0
      z(6) = 1     ! NH/IH
      call make_dist_event(feventdist,z,xmin,xmax,ndiv,hmode,evform
     &     ,nevent,serror,snmax,norm,'edh3nh.dat',eventnh,neventnh)
      z(6) = -1     ! NH/IH
      call make_dist_event(feventdist,z,xmin,xmax,ndiv,hmode,evform
     &     ,nevent,serror,snmax,norm,'edh3ih.dat',eventih,neventih)
      dchi2 = 0d0
      do i = 1,ndiv
         dchi2 = dchi2 +( eventnh(i) -eventih(i) )**2 / eventnh(i)
      enddo
      write(2,*) "Naive Delta-Chi2(NH,3%) = ",dchi2
      dchi2 = 0d0
      do i = 1,ndiv
         dchi2 = dchi2 +( eventnh(i) -eventih(i) )**2 / eventih(i)
      enddo
      write(2,*) "Naive Delta-Chi2(IH,3%) = ",dchi2

      Eres = 0.015d0
      ndiv = (xmax -xmin )/Eres*2d0
      z(6) = 1     ! NH/IH
      call make_dist_event(feventdist,z,xmin,xmax,ndiv,hmode,evform
     &     ,nevent,serror,snmax,norm,'edh1nh.dat',eventnh,neventnh)
      z(6) = -1     ! NH/IH
      call make_dist_event(feventdist,z,xmin,xmax,ndiv,hmode,evform
     &     ,nevent,serror,snmax,norm,'edh1ih.dat',eventih,neventih)
      dchi2 = 0d0
      do i = 1,ndiv
         dchi2 = dchi2 +( eventnh(i) -eventih(i) )**2 / eventnh(i)
      enddo
      write(2,*) "Naive Delta-Chi2(NH,1.5%) = ",dchi2
      dchi2 = 0d0
      do i = 1,ndiv
         dchi2 = dchi2 +( eventnh(i) -eventih(i) )**2 / eventih(i)
      enddo
      write(2,*) "Naive Delta-Chi2(IH,1.5%) = ",dchi2

      close(2)


      open(2,file='norm.dat',status='replace')
      write(2,*) norm
      close(2)

      end

