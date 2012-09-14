C -*- fortran -*-
         z_dat(10) = 20    ! N vs. sqrt(E)
         include 'bining_value.inc'

         hmode = 0
         z_min(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_min,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="evdinhmin.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
