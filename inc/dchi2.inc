C -*- fortran -*-
         z_dat(10) = 20 ! N vs. sqrt(E)
         hmode = 1 ! 0:continuous 1:simpson 2:center-value 

         if (iswitch_smear.eq.0) then
            include 'bining_Eres.inc'
c            include 'bining_value.inc'
         elseif (iswitch_smear.eq.1) then
            include 'bining_dx.inc'
c            include 'bining_value.inc'
         endif

         evform_dat = 2
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr1) 
         call smearing(event_dat,nbins,rdx,Eres,event2_dat,iswitch_smear)         
        
         evform_th = 2
         call MakeHisto1D(nout,hfunc1D,z,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &        ,nevent_th,ierr2)
         call smearing(event_th,nbins,rdx,Eres,event2_th,iswitch_smear)

            dchisq = dchi2(nout,event2_dat,event2_th,nbins,npar,z,z_dat
     &           ,error)  

