C -*- fortran -*-
         z_dat(10) = 20
         hmode = 1
         z_dat(6) = 1
         include 'bining_Eres.inc'  ! bining by Eres

         evform_dat = 2
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr1)
         z_dat(6) = -1
         evform_th = 2
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &        ,nevent_th,ierr2)
         z_min(6) = -1
c         z_dat(6) = 1
         evform_th = 2
         call MakeHisto1D(nout,hfunc1D,z_min,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_fit,hevent_fit
     &        ,nevent_fit,ierr2)
         open(1,file="event_min2nh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i-1)**2+0.8d0,event_dat(i),event_th(i),event_fit(i)
         enddo
         close(1)
 200  continue
