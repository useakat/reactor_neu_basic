C -*- fortran -*-
         z_dat(15) = 20 ! N vs. sqrt(E)
c         z_dat(15) = 100 ! N vs. sqrt(E)
         hmode = 1 ! 0:continuous 1:simpson 2:center-value 
         evform_dat = 2
         evform_th = 2
         include 'bining_dx.inc'

         if (ifirst.eq.0) then
            call MakeHisto1D_stat(nout,hfunc1D,z_dat,nevent,nbins,x
c            call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &           ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &           ,nevent_dat,ierr1) 
c     call smearing(event_dat,nbins,rdx,Eres,event2_dat)         
            call smearing_nl(event_dat,x,nbins,rdx,Eres,Eres_nl,event2_dat)         
            ifirst = 1
         endif

         call MakeHisto1D(nout,hfunc1D,z,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &        ,nevent_th,ierr2)
c         call smearing(event_th,nbins,rdx,Eres,event2_th)
         call smearing_nl(event_th,x,nbins,rdx,Eres,Eres_nl,event2_th)         

c            dchisq = chi2(nout,event2_dat,event2_th,nbins,npar,z,z_dat
c     &           ,error)  
            chisq_wrong = chi2_2(nout,event2_dat,event2_th,nbins,npar,z
     &        ,z_dat,error)  

            dchisq = chisq_wrong
