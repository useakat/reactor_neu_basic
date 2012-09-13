C -*- fortran -*-
CCCCCCCCCCCCCCCCCCCCCCC test  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
         Eres = 0.06d0
         xmin = dsqrt(Emin-0.8d0)                           
         xmax = dsqrt(Emax-0.8d0)
         nbins = int( ( xmax -xmin ) / rdx ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +rdx*i
         enddo

         z_dat(10) = 20 
         evform_dat = 2   ! 1:integer 2:real*8
         hmode = 2        ! 0:continuous 1:simpson 2:center-value 
         iswitch_smear = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         call smearing(event_dat,nbins,rdx,Eres,event2_dat,iswitch_smear)
         open(1,file="FluxXsec2.dat",status="replace")
         do i = 1,nbins
            write(1,'(6e18.8)') x(i),hevent_dat(i),event_dat(i)
     &           ,nevent_dat,event2_dat(i)/rdx,event2_dat(i)
         enddo
         close(1)