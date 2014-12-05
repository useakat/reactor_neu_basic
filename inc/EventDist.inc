C -*- fortran -*-
         z_dat(15) = 20    ! N vs. sqrt(E)
         hmode = 1              ! 0:continuous 1:simpson 2:center-value 
         evform_dat = 2   ! 1:integer 2:real*8
c         include 'bining_value.inc'  ! bining by value
         include 'inc/bining_dx.inc' ! Make bins for x = dsqrt{E_vis}, E_vis = E_nu -0.8 [MeV]

         z_dat(11) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
c         call smearing(event_dat,nbins,rdx,Eres,event2_dat)         
         call smearing_nl(event_dat,x,nbins,rdx,Eres,Eres_nl,event2_dat)         
         open(1,file="evdinh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),event2_dat(i)/rdx,event2_dat(i),nevent_dat
c            write(1,*) x(i),event_dat(i)/rdx,event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(11) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
c         call smearing(event_dat,nbins,rdx,Eres,event2_dat)         
         call smearing_nl(event_dat,x,nbins,rdx,Eres,Eres_nl,event2_dat)         
         open(1,file="evdiih.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),event2_dat(i)/rdx,event2_dat(i),nevent_dat
         enddo
         close(1)

C$$$         hmode = 1       ! 0:continuous 1:simpson 2:center-value 
C$$$         evform_dat = 1   ! 1:integer 2:real*8
C$$$         include 'bining_Eres.inc'
C$$$         z_dat(11) = 1
C$$$         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
C$$$     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
C$$$     &        ,nevent_dat,ierr)
C$$$         open(1,file="edh6nh.dat",status="replace")
C$$$         do i = 1,nbins
C$$$            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
C$$$         enddo
C$$$         close(1)
C$$$         z_dat(11) = -1
C$$$         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
C$$$     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
C$$$     &        ,nevent_dat,ierr)
C$$$         open(1,file="edh6ih.dat",status="replace")
C$$$         do i = 1,nbins
C$$$            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
C$$$         enddo
C$$$         close(1)
