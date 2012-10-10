C -*- fortran -*-
         z_dat(15) = 0    ! N vs E_{\nu}
         hmode = 0        ! 0:continuous 1:simpson 2:center-value 
         evform_dat = 2   ! 1:integer 2:real*8
c         include 'bining_dx.inc'
         include 'bining_E.inc'

         z_dat(11) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
c         call smearing(event_dat,nbins,rdx,Eres,event2_dat)         
c         call smearing_nl(event_dat,x,nbins,rdbin,Eres,Eres_nl
c     &        ,event2_dat)         
         open(1,file="N_nh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(11) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
c         call smearing(event_dat,nbins,rdx,Eres,event2_dat)         
c         call smearing_nl(event_dat,x,nbins,rdx,Eres,Eres_nl,event2_dat)         
         open(1,file="N_ih.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
