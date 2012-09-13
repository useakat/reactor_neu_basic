C -*- fortran -*-
         hmode = 0              ! 0:continuous 1:simpson 2:center-value 
         xmin = dsqrt(Emin-0.8d0)
         xmax = dsqrt(Emax-0.8d0)
c         nbins = int( ( xmax -xmin ) / rdx ) ! nbins should be less than 100000
c         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000 
         nbins = 100
         do i = 0,nbins
            x(i) = xmin +( xmax -xmin ) / dble(nbins)*i
         enddo
         z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="evdinh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="evdiih.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         hmode = 1       ! 0:continuous 1:simpson 2:center-value 
         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +Eres/2d0*i
         enddo
         z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="edh6nh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="edh6ih.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
