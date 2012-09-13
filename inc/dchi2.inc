C -*- fortran -*-
         z_dat(10) = 20 ! N vs. sqrt(E)			
         hmode = 1 ! 0:continuous 1:simpson 2:center-value 
         xmin = dsqrt(Emin-0.8d0)
         xmax = dsqrt(Emax-0.8d0)
c         nbins = int( ( xmax -xmin ) / rdx ) ! nbins should be less than 100000
c         do i = 0,nbins
c            x(i) = xmin +rdx*i
c         enddo
         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +Eres/2d0*i
         enddo
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr1)
         call smearing(event_dat,nbins,rdx,Eres,event2_dat,iswitch_smear)
                 
         call MakeHisto1D(nout,hfunc1D,z,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &        ,nevent_th,ierr2)
         call smearing(event_th,nbins,rdx,Eres,event2_th,iswitch_smear)
cc         if ( (ierr1.ne.0).or.(ierr2.ne.0) ) then
c            dchisq = 1d10
c         else
            dchisq = dchi2(nout,event_dat,event_th,nbins,npar,z,z_dat
     &           ,error)  
c     endif
