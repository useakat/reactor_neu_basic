C -*- fortran -*-
      z_dat(15) = 20
c      include 'bining_value.inc' ! bining by value
      include 'bining_dx.inc'
      hmode = 1
      evform_dat = 2

      z_min(11) = 1
c      z_dat(11) = 1
c      call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x 
      call MakeHisto1D(nout,hfunc1D,z_min,nevent,nbins,x
     &     ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &     ,nevent_dat,ierr)
c      call smearing(event_dat,nbins,rdx,Eres,event2_dat)         
      call smearing_nl(event_dat,x,nbins,rdx,Eres,Eres_nl,event2_dat)         
      open(1,file="evdiihmin.dat",status="replace")
      do i = 1,nbins
         write(1,*) x(i),event2_dat(i)/rdx,event2_dat(i),nevent_dat
      enddo
      close(1)
