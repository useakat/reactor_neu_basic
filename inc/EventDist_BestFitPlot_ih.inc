C -*- fortran -*-
      z_dat(10) = 20
c      include 'bining_value.inc' ! bining by value
      include 'bining_dx.inc'
      hmode = 1
      evform_dat = 2

      z_min(6) = 1
      call MakeHisto1D(nout,hfunc1D,z_min,nevent,nbins,x
     &     ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &     ,nevent_dat,ierr)
      call smearing(event_dat,nbins,rdx,Eres,event2_dat)         
      open(1,file="evdiihmin.dat",status="replace")
      do i = 1,nbins
         write(1,*) x(i),event2_dat(i)/rdx,event2_dat(i),nevent_dat
      enddo
      close(1)
